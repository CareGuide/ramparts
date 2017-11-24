# frozen_string_literal: true

# Parses text and attempts to locate phone numbers
class PhoneParser
  def find_phone_number_instances(block, options)
    # Parses the string and returns a string of hyphens (-) and digits
    parsed_block = parse_phone_number(block, options)

    # Returns the starting index and the length of the matched instance for every instance
    instances =
      parsed_block
      .enum_for(:scan, ALLOWABLE_REGEX)
      .map { [Regexp.last_match.begin(0), Regexp.last_match.to_s] }
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
    'zero' => '0'
  }.freeze

  LEET_REPLACEMENTS = {
    'w0n' => '1',
    'too' => '2',
    'thr33' => '3',
    'f0r' => '4',
    'f1v3' => '5',
    's3x' => '6',
    'sex' => '6',
    's3v3n' => '7',
    'at3' => '8',
    'nin3' => '9'
  }.freeze

  def parse_phone_number(block, options)
    block = block.delete(' ') if options.fetch(:remove_spaces, false)

    block = block.downcase.gsub(/one|two|three|four|five|six|seven|eight|nine|oh|zero/, REPLACEMENTS)

    if options.fetch(:parse_leet, false)
      block = block.gsub(/w0n|too|thr33|f0r|f1v3|s3x|sex|s3v3n|at3|nin3/, LEET_REPLACEMENTS)
    end

    block.gsub(/[^\w]/, '-').gsub(/[a-zA-Z]/, '.')
  end
end
