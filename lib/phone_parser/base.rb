require 'pry'

module PhoneParserModule
  class PhoneParser
    def find_phone_number_instances(block)
      # Parses the string and returns a string of hyphens (-) and digits
      parsedBlock = parse_phone_number(block)

      # Returns the starting index and the length of the matched instance for every instance
      instances = parsedBlock.enum_for(:scan, ALLOWABLE_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.length] }
      instances
    end

    private

    ALLOWABLE_REGEX = Regexp.new(/(\-*\.?\d{1}\.?\-*){7,}/)

    REPLACEMENTS = {
        'one' => '1',
        'two' => '2',
        'three' => '3',
        'four' => '4',
        'five' => '5',
        'six' => '6',
        'seven' => '7',
        'eight' => '8',
        'nine' => '9',
        'oh' => '0',
        'zero' => '0',
    }

    def parse_phone_number(block)
      block.downcase.gsub(/one|two|three|four|five|six|seven|eight|nine|oh|zero/, REPLACEMENTS).gsub(/[^\w]/, "-").gsub(/[a-zA-Z]/, ".")
    end
  end

  class EmailParser
    def find_email_instances(block)
      block = parse_email(block)
      instances = block.enum_for(:scan, ALLOWABLE_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.length] }
      # binding.pry
      instances
    end

    private

    ALLOWABLE_REGEX = Regexp.new(/[a-z0-9._%+-]+\${,2}@{1}\${,2}[a-z0-9.-]+\${,2}(\.){1}/)

    REPLACEMENTS = {
        ' at ' => '@',
        '(at)' => '@',
        ' dot ' => '.',
    }

    def parse_email(block)
      block.downcase.gsub(/\ at\ |\(at\)|\ dot\ /, REPLACEMENTS).gsub(/[^\w\@\.\_\%\+\-]/, "$")
    end
  end

  class UrlParser
    def find_url_instances(block)
      block = parse_url(block)
      instances = block.enum_for(:scan, BAD_URL_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s.length] }
      instances
    end

    private

    BAD_URL_REGEX = Regexp.union(/cialis/, /viagra/)


    def parse_url(block)
      block.downcase
    end
  end

  def find_phone_number(block)
    pp = PhoneParser.new
    pp.find_phone_number_instances(block)
  end

  def find_emails(block)
    ep = EmailParser.new
    ep.find_email_instances(block)
  end

  def find_urls(block)
    up = UrlParser.new
    up.find_url_instances(block)
  end

end