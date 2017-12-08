# frozen_string_literal: true

require_relative '../data/list_of_email_domains'
require_relative '../helpers'

# Parses text and attempts to locate email
class EmailParser
  # Counts email occurrences within a block of text
  # Note: Uses map reduce algorithm
  def count_email_instances(text, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless text.is_a? String

    text = parse_email(text)
    email_instances(MR_ALGO, text, options).length
  end

  # Replaces the occurrences of email within the block of text with an insertable
  def replace_email_instances(text, insertable, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless text.is_a? String

    instances = find_email_instances(text, options)
    instances.map do |(start_offset, text)|
      text[start_offset...start_offset + text.size] = insertable
    end

    text
  end

  # Fins the occurrences of emails within a block of text and returns their positions
  def find_email_instances(text, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless text.is_a? String

    text = text.downcase
    email_instances(GR_ALGO, text, options)
  end

  private

  # Matches a certain string of text allowed in emails
  TEXT_MATCH = 'a-z0-9._%+-'

  # rubocop:disable LineLength

  # Regex to find the emails, must have .com or something similar to match
  GR_REGEX = Regexp.new(/(([#{TEXT_MATCH}]{1}[^\w]{1})+|([#{TEXT_MATCH}])+)([^\w]+(at){1}[^\w]+|[^\w]*@[^\w]*){1}[a-z0-9.-]+(([^\w]*\.[^\w]*|[^\w]+(dot){1}[^\w]+){1}[a-z]{2,})+/)
  # Regex to find the emails, does .com or something similar to match
  GR_REGEX_WITHOUT_DOT = Regexp.new(/(([#{TEXT_MATCH}]{1}[^\w]{1})+|([#{TEXT_MATCH}])+)([^\w]+(at){1}[^\w]+|[^\w]*@[^\w]*){1}[a-z0-9.-]+([^\w]*\.[^\w]*|[^\w]+(dot){1}[^\w]+)?([a-z]{2,})?/)

  # rubocop:enable LineLength

  # Regex to find emails for MapReduce, must have .com or something similar to match
  MR_REGEX = Regexp.new(/[a-z0-9._%+-]+\${,2}@{1}\${,2}[a-z0-9.-]+\${,2}(\.){1}/)
  # Regex to find emails for MapReduce, does not have to have .com or something similar to match
  MR_REGEX_WITHOUT_DOT = Regexp.new(/[a-z0-9._%+-]+\${,2}@{1}\${,2}[a-z0-9.-]+\${,2}/)

  # Map these occurences down to their constituent parts
  REPLACEMENTS = {
    ' at ' => '@',
    '(at)' => '@',
    ' dot ' => '.'
  }.freeze

  # Parses the email and maps down certain occurrences
  def parse_email(text)
    text.downcase.gsub(/\ at\ |\(at\)|\ dot\ /, REPLACEMENTS).gsub(/[^\w\@\.\_\%\+\-]/, '$')
  end

  def email_instances(algo, text, options)
    # Determines which algorithm to use
    regex = algo == MR_ALGO ? MR_REGEX : GR_REGEX
    regex_without_dot = algo == MR_ALGO ? MR_REGEX_WITHOUT_DOT : GR_REGEX_WITHOUT_DOT

    instances = []
    if options.fetch(:aggressive, false)
      temp_instances =
        text
        .enum_for(:scan, regex_without_dot)
        .map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.strip] }

      # Since this is the aggressive option where '.com' or similar isn't needed
      # Check to make sure the last word of the string is a domain
      temp_instances.each do |instance|
        instances << instance if EMAIL_DOMAINS.any? { |domain| instance[1].split('@')[1]&.include? domain }
      end
    else
      instances =
        text
        .enum_for(:scan, regex)
        .map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.strip] }
    end
    instances
  end
end
