# frozen_string_literal: true

require './lib/spam_parser'
require_relative 'data/phone_data/truthy_phone_data'
require_relative 'data/phone_data/falsy_phone_data'
include SpamParserModule

# Generic test blocks
TEST_BLOCK_1 = 'one two three four five six seven eight nine oh'

describe SpamParserModule do
  it 'parses all the numbers correctly' do
    @phone_parser = PhoneParser.new
    expect(@phone_parser.send(:parse_phone_number, TEST_BLOCK_1, {})).to eql('1-2-3-4-5-6-7-8-9-0')
  end
  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_phone_numbers(block[1]).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end

  it 'parses a number of positive test blocks correctly with parse_leet option' do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_phone_numbers(block[1], parse_leet: true).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end

  it 'parses a number of positive test blocks correctly with remove_spaces option' do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_phone_numbers(block[1], remove_spaces: true).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end

  it 'parses a number of positive test blocks correctly with remove_spaces and parse_leet option' do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_phone_numbers(block[1], remove_spaces: true, parse_leet: true).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end

  it 'parses a number of negative test blocks correctly' do
    FALSY_BLOCKS.each do |block|
      number_of_matches = find_phone_numbers(block).length
      expect(number_of_matches).to eq(0), "Expected empty array, got #{number_of_matches} for #{block}"
    end
  end
end
