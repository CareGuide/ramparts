# frozen_string_literal: true

require_relative '../helpers'

# Parses text and attempts to locate phone numbers
class PhoneParser
  # Counts the number of phone number instances that occur within the block of text
  def count_phone_number_instances(block, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless block.is_a? String

    # Parses the string and returns a string of hyphens (-) and digits
    parsed_block = parse_phone_number(block, options)

    # Returns the starting index and the length of the matched instance for every instance
    # Uses the Map Reduce algorithm
    phone_number_instances(MR_ALGO, parsed_block, options).length
  end

  # Replaces phone number instances within the block of text with the insertable
  def replace_phone_number_instances(block, insertable, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless block.is_a? String

    # Finds the phone number instances within the text
    instances = find_phone_number_instances(block, options)

    # Replaces those instances with the insertable
    instances.map do |(start_offset, text)|
      block[start_offset...start_offset + text.size] = insertable
    end

    # Returns the amended block of text
    block
  end

  #
  def find_phone_number_instances(block, options)
    raise ArgumentError, ARGUMENT_ERROR_TEXT unless block.is_a? String

    # Finds the phone number instances using a glorified regex
    block = block.downcase
    phone_number_instances(GR_ALGO, block, options)
  end

  private

  # Phonetic versions of numbers
  PHONETICS = %w[
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
    oh
    zero
  ].freeze

  # L33t speak versions of numbers
  LEET_SPEAK = %w[
    w0n
    too
    thr33
    f0r
    f1v3
    s3x
    sex
    s3v3n
    at3
    nin3
  ].freeze

  # Handles multiple spaces
  MULTI_SPACE = '( )*'

  # Regex for phonetics, both with spaces and otherwise
  REGEX_PHONETICS = PHONETICS.join('|')
  REGEX_PHONETICS_SPACED = PHONETICS.map { |word| word.split('').join(MULTI_SPACE) }.join('|')

  # Regex for l33t, both with spaces and otherwise
  REGEX_LEET_SPEAK = LEET_SPEAK.join('|')
  REGEX_LEET_SPEAK_SPACED = LEET_SPEAK.map { |word| word.split('').join(MULTI_SPACE) }.join('|')

  # Base matching for a possible phone number digit
  BASE_MATCHING = "#{REGEX_PHONETICS}|#{REGEX_LEET_SPEAK}|#{REGEX_PHONETICS_SPACED}|#{REGEX_LEET_SPEAK_SPACED}"

  # The final regex used to match phone numbers for GR
  GR_REGEX =
    Regexp.new(/(\()?(\d|#{BASE_MATCHING}){1}([^\w]*(\d|#{BASE_MATCHING}){1}[^\w]*){5,}(\d|#{BASE_MATCHING}){1}/)

  # The final regex used to match phone numbers for MR
  MR_REGEX = Regexp.new(/(\-*\.?\d{1}\.?\-*){7,}/)

  # Replacements used for phonetics for MR
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

  # Replacements used for l33t for MR
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

  # Parses the phone number for MR, uses a variety of options
  def parse_phone_number(block, options)
    block = block.delete(' ') if options.fetch(:remove_spaces, false)

    block = block.downcase.gsub(/#{REGEX_PHONETICS}/, REPLACEMENTS)

    if options.fetch(:parse_leet, false)
      block = block.gsub(/#{REGEX_LEET_SPEAK}/, LEET_REPLACEMENTS)
    end

    block.gsub(/[^\w]/, '-').gsub(/[a-z]/, '.')
  end

  # Returns the phone number instances using the specified algorithm
  def phone_number_instances(algo, block, _options)
    # Determines which algorithm to use
    regex = algo == MR_ALGO ? MR_REGEX : GR_REGEX

    # Returns the starting index and the length of the matched instance for every instance
    instances =
      block
      .enum_for(:scan, regex)
      .map { [Regexp.last_match.begin(0), Regexp.last_match.to_s] }
    instances
  end
end
