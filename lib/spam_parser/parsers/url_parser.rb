# frozen_string_literal: true

require_relative '../helpers'

# Parses text and attempts to find urls
class UrlParser
  # Counts the number of occurrences of that url within the block of text
  def count_url_instances(text, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless text.is_a? String

    text = parse_url(text)
    url_instances(text, options).length
  end

  private

  BAD_URL_REGEX = Regexp.union(/cialis/, /viagra/)

  # Parses the url to make it easier to search
  def parse_url(text)
    text.downcase
  end

  # Returns the instances that match the regex
  def url_instances(text, _options)
    text
      .enum_for(:scan, BAD_URL_REGEX)
      .map { { offset: Regexp.last_match.begin(0), value: Regexp.last_match.to_s.strip } }
  end
end
