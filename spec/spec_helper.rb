# frozen_string_literal: true

# Load first so it can track the application code
require 'simplecov'
SimpleCov.start

require './lib/ramparts'
require 'spec_constants'

# Times a method run length in milliseconds
def time_method(method, *args)
  beginning_time = Time.now
  Ramparts.send(method, args[0])
  end_time = Time.now
  milliseconds = (end_time - beginning_time) * 1000
  milliseconds
end

# Compares the run time of two methods
# In this case the MR and GR algos
def compare_run_times(tests, method1, method2)
  total_time_map_reduce = 0
  total_time_regex = 0

  tests.each do |test|
    map_reduce_time = time_method(method1, test[:text])
    regex_time = time_method(method2, test[:text])

    total_time_map_reduce += map_reduce_time
    total_time_regex += regex_time
  end

  puts
  puts "Map Reduce Total Time: #{total_time_map_reduce.round(2)} milliseconds"
  puts "Regex Total Time: #{total_time_regex.round(2)} milliseconds"
end

# Test helper for testing truthy values against count type methods
def test_truthy_count(tests, method, options = {})
  tests.each do |test|
    matches = Ramparts.send(method, test[:text], options)
    expect(matches)
      .to eq(test[:matches].length),
          "Expected #{test[:matches].length}, got #{matches} for '#{test[:text]}'"
  end
end

# Test helper for testing truthy values against find type methods
def test_truthy_finds(tests, method, options = {})
  tests.each do |test|
    matches = Ramparts.send(method, test[:text], options)
    test[:matches].each_with_index do |match_string, index|
      if matches[index].nil? || matches[index][:value].casecmp(match_string) != 0
        got_result = matches[index].nil? ? 'NIL' : matches[index][:value]
        raise "Expected: #{match_string}\nGot: #{got_result}\nBlock '#{test[:text]}'\nResult: #{matches}"
      end
    end
  end
end

# Test helper for testing truthy values against find type methods
def test_replacements(tests, method, options = {})
  tests.each do |test|
    text = Ramparts.send(method, test[:text], options) do
      INSERTABLE
    end
    if text.casecmp(test[:filtered]) != 0
      raise "Expected: #{test[:filtered]}\nGot: #{text}\nBlock '#{test[:filtered]}'"
    end
  end
end

# Test helper for testing falsy values against count type methods
def test_falsy_count(tests, method, options = {})
  tests.each do |test|
    matches = Ramparts.send(method, test, options)
    expect(matches).to eq(0), "Expected empty array, got #{matches} for '#{test}'"
  end
end

# Test helper for testing falsy values against find type methods
def test_falsy_finds(tests, method, options = {})
  tests.each do |test|
    matches = Ramparts.send(method, test, options)
    expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{test}'"
  end
end
