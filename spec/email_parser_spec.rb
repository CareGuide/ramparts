# frozen_string_literal: true

require './lib/spam_parser'
require_relative 'data/email_data/truthy_email_data'
require_relative 'data/email_data/falsy_email_data'

describe "the spam parser module" do
  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_emails(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive test blocks correctly with aggressive option' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_emails(block[1], aggressive: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of positive aggressive test blocks correctly with aggressive option' do
    TRUTHY_AGGRESSIVE_BLOCKS.each do |block|
      matches = count_emails(block[1], aggressive: true)
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of negative test blocks correctly' do
    FALSY_BLOCKS.each do |block|
      matches = count_emails(block)
      expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
    end
  end

  # Regex only
  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS.each do |block|
      matches = find_emails(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  # it 'parses a number of positive test blocks correctly with aggressive option and regex only' do
  #   TRUTHY_BLOCKS.each do |block|
  #     matches = replace_emails(block[1], "Cool", aggressive: true)
  #     expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
  #   end
  # end

  # it 'parses a number of positive aggressive test blocks correctly with aggressive option and regex only' do
  #   TRUTHY_AGGRESSIVE_BLOCKS.each do |block|
  #     matches = replace_emails(block[1], "Neato", aggressive: true)
  #     expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
  #   end
  # end

  it 'parses a number of negative test blocks correctly and regex only' do
    FALSY_BLOCKS.each do |block|
      matches = find_emails(block)
      expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
    end
  end
end
