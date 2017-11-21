require "./lib/phone_parser"
require_relative "./url_data/truthy_url_data"
require_relative "./url_data/falsy_url_data"
include PhoneParserModule

describe PhoneParserModule do
  it "parses a number of positive test blocks correctly" do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_urls(block[1]).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end
    it "parses a number of negative test blocks correctly" do
    FALSY_BLOCKS.each do |block|
      number_of_matches = find_urls(block).length
      expect(number_of_matches).to eq(0), "Expected empty array, got #{number_of_matches} for #{block}"
    end
  end
end