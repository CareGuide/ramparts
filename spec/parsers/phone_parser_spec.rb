# frozen_string_literal: true

require './lib/ramparts'
require_relative '../spec_helper_methods'
require_relative '../data/phone_data/truthy_phone_data'
require_relative '../data/phone_data/falsy_phone_data'

describe '#count_phone_numbers' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_count(PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers)
  end

  it 'parses a number of positive test blocks correctly with parse_leet option' do
    test_truthy_count(PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers, parse_leet: true)
  end

  it 'parses a number of spaced positive test blocks correctly with remove_spaces option' do
    test_truthy_count(PHONE_TRUTHY_WITH_ANSWERS_AND_SPACES, :count_phone_numbers, remove_spaces: true)
  end

  it 'parses a number of positive test blocks correctly with remove_spaces and parse_leet option' do
    test_truthy_count(PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers, parse_leet: true, remove_spaces: true)
  end

  it 'parses a number of negative test blocks correctly' do
    test_falsy_count(PHONE_FALSY_BLOCKS, :count_phone_numbers)
  end

  it 'parses a number of negative test blocks correctly with all the options' do
    test_falsy_count(PHONE_FALSY_BLOCKS, :count_phone_numbers, parse_leet: true, remove_spaces: true)
  end
end

describe '#find_phone_numbers' do
  it 'parses a number of positive test blocks correctly with glorified regex' do
    test_truthy_finds(PHONE_TRUTHY_WITH_ANSWERS, :find_phone_numbers)
  end

  it 'parses a number of positive test blocks correctly' do
    test_truthy_finds(PHONE_TRUTHY_WITH_ANSWERS_AND_SPACES, :find_phone_numbers)
  end

  it 'parses a number of negative test blocks correctly with glorified regex' do
    test_falsy_finds(PHONE_FALSY_BLOCKS, :find_phone_numbers)
  end
end

describe 'Map/Reduce to Regex Run Time' do
  it 'times the two methods against each other' do
    compare_run_times(PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers, :find_phone_numbers)
  end
end
