# frozen_string_literal: true

# Parses text and attempts to find urls
class UrlParser
  def find_url_instances(block)
    block = parse_url(block)
    instances = block.enum_for(:scan, BAD_URL_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s] }
    instances
  end

  private

  BAD_URL_REGEX = Regexp.union(/cialis/, /viagra/)

  def parse_url(block)
    block.downcase
  end
end
