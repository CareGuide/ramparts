# frozen_string_literal: true

require_relative '../helpers'

# Parses text and attempts to find urls
class UrlParser
  # Counts the number of occurrences of that url within the block of text
  def count_url_instances(block, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless block.is_a? String

    # Returns the number of instances that match within the block of text
    block = parse_url(block)
    url_instances(block, options).length
  end

  private

  BAD_URL_REGEX = Regexp.union(/cialis/, /viagra/)

  # Parses the url to make it easier to search
  def parse_url(block)
    block.downcase
  end

  # Returns the instances that match the regex
  def url_instances(block, _options)
    block.enum_for(:scan, BAD_URL_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.strip] }
  end
end
