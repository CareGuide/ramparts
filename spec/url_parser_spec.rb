# frozen_string_literal: true

require './lib/spam_parser'
require_relative 'data/url_data/truthy_url_data'
require_relative 'data/url_data/falsy_url_data'

describe "The spam parser module" do
  it 'parses a number of positive test blocks correctly' do
    TRUTHY_BLOCKS.each do |block|
      matches = count_urls(block[1])
      expect(matches.length).to eq(block[0]), "Expected #{block[0]}, got #{matches.length} for '#{block[1]}'\n Result: #{matches}"
    end
  end

  it 'parses a number of negative test blocks correctly' do
    FALSY_BLOCKS.each do |block|
      matches = count_urls(block)
      expect(matches.length).to eq(0), "Expected empty array, got #{matches.length} for '#{block}'"
    end
  end
end
