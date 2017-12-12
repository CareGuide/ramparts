# frozen_string_literal: true

require './lib/ramparts'

INSERTABLE = 'CENSORED'

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
def compare_run_times(iterator, method1, method2)
  total_time_map_reduce = 0
  total_time_regex = 0

  iterator.each do |block|
    map_reduce_time = time_method(method1, block[1])
    regex_time = time_method(method2, block[1])

    total_time_map_reduce += map_reduce_time
    total_time_regex += regex_time
  end

  puts
  puts "Map Reduce Total Time: #{total_time_map_reduce.round(2)} milliseconds"
  puts "Regex Total Time: #{total_time_regex.round(2)} milliseconds"
end

# Test helper for testing truthy values against count type methods
def test_truthy_count(iterator, method, options = {})
  iterator.each do |block|
    matches = Ramparts.send(method, block[1], options)
    expect(matches)
      .to eq(block[0].length),
          "Expected #{block[0].length}, got #{matches} for '#{block[1]}'"
  end
end

# Test helper for testing truthy values against find type methods
def test_truthy_finds(iterator, method, options = {})
  iterator.each do |block|
    matches = Ramparts.send(method, block[1], options)
    block[0].each_with_index do |match_string, index|
      if matches[index].nil? || matches[index][:value].casecmp(match_string) != 0
        got_result = matches[index].nil? ? 'NIL' : matches[index][:value]
        raise "Expected: #{match_string}\nGot: #{got_result}\nBlock '#{block[1]}'\nResult: #{matches}"
      end
    end
  end
end

# Test helper for testing truthy values against find type methods
def test_replacements(iterator, method, options = {})
  iterator.each do |block|
    text = Ramparts.send(method, block[1], INSERTABLE, options)
    if text.casecmp(block[2]) != 0
      raise "Expected: #{block[2]}\nGot: #{text}\nBlock '#{block[1]}'"
    end
  end
end

# Test helper for testing falsy values against count type methods
def test_falsy_count(iterator, method, options = {})
  iterator.each do |block|
    matches = Ramparts.send(method, block, options)
    expect(matches).to eq(0), "Expected empty array, got #{matches} for '#{block}'"
  end
end

# Test helper for testing falsy values against find type methods
def test_falsy_finds(iterator, method, options = {})
  iterator.each do |block|
    matches = Ramparts.send(method, block, options)
    expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
  end
end
