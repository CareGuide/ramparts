# frozen_string_literal: true

require './lib/spam_parser'
require_relative 'data/phone_data/truthy_phone_data'
require_relative 'data/phone_data/falsy_phone_data'

# Generic test blocks
TEST_BLOCK_1 = 'one two three four five six seven eight nine oh'

def time_method(method, *args)
  beginning_time = Time.now
  self.send(method, args[0])
  end_time = Time.now
  milliseconds = (end_time - beginning_time)*1000
  milliseconds
end

describe "the spam parser module" do
  it 'parses all the numbers correctly' do
    @phone_parser = PhoneParser.new
    expect(@phone_parser.send(:parse_phone_number, TEST_BLOCK_1, {})).to eql('1-2-3-4-5-6-7-8-9-0')
  end
  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_phone_numbers(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS_WITH_ANSWER.each do |block|
      matches = count_phone_numbers(block[1])
      expect(matches.length).to eq(block[0].length), "Expected #{block[0].length}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS_WITH_ANSWER.each do |block|
      matches = find_phone_numbers(block[1])
      block[0].each_with_index do |match_string, index|
        if matches[index].nil? || matches[index][1].downcase != match_string.downcase
          raise "Expected: #{match_string}\nGot: #{matches[index].nil? ? "NIL" : matches[index][1]}\nBlock '#{block[1]}'\nResult: #{matches}"
        end
      end
    end
  end

  it 'parses a number of positive test blocks correctly with parse_leet option' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_phone_numbers(block[1], parse_leet: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive test blocks correctly with remove_spaces option' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_phone_numbers(block[1], remove_spaces: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end

    TRUTHY_SPACED_BLOCKS.each do |block|
      matches = count_phone_numbers(block[1], remove_spaces: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive test blocks correctly with remove_spaces and parse_leet option' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_phone_numbers(block[1], remove_spaces: true, parse_leet: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of negative test blocks correctly' do
    FALSY_BLOCKS.each do |block|
      matches = count_phone_numbers(block)
      expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
    end
  end

  it 'parses a number of positive test blocks correctly with glorified regex' do
    TRUTHY_BLOCKS.each do |block|
      matches = find_phone_numbers(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end

    TRUTHY_SPACED_BLOCKS.each do |block|
      matches = find_phone_numbers(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of negative test blocks correctly with glorified regex' do
    FALSY_BLOCKS.each do |block|
      matches = find_phone_numbers(block)
      expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
    end
  end

  it 'times the two methods against each other' do
    all_output = false
    total_time_map_reduce = 0
    total_time_regex = 0

    TRUTHY_BLOCKS.each do |block|
      map_reduce_time = time_method(:count_phone_numbers, block[1])
      regex_time = time_method(:find_phone_numbers, block[1])

      total_time_map_reduce += map_reduce_time
      total_time_regex += regex_time

      if all_output
        puts "#####################"
        puts "Map Reduce: #{map_reduce_time.round(2)}"
        puts "Regex Time: #{regex_time.round(2)}"
        puts "#####################"
      end
    end

    puts
    puts "Map Reduce Total Time: #{total_time_map_reduce.round(2)} milliseconds"
    puts "Regex Total Time: #{total_time_regex.round(2)} milliseconds"
  end
end
