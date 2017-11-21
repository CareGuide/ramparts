require "./lib/phone_parser"
require_relative "./phone_data/truthy_phone_data"
require_relative "./phone_data/falsy_phone_data"
include PhoneParserModule

# Generic test blocks
TEST_BLOCK_1 = "one two three four five six seven eight nine oh"

describe PhoneParserModule do
  it "parses all the numbers correctly" do
    @phone_parser = PhoneParser.new
    expect(@phone_parser.send(:parse_phone_number, TEST_BLOCK_1)).to eql("1-2-3-4-5-6-7-8-9-0")
  end
  it "parses a number of positive test blocks correctly" do
    TRUTHY_BLOCKS.each do |block|
      number_of_matches = find_phone_number(block[1]).length
      expect(number_of_matches).to eq(block[0]), "Expected #{block[0]}, got #{number_of_matches} for #{block[1]}"
    end
  end
  it "parses a number of negative test blocks correctly" do
    FALSY_BLOCKS.each do |block|
      number_of_matches = find_phone_number(block).length
      expect(number_of_matches).to eq(0), "Expected empty array, got #{number_of_matches} for #{block}"
    end
  end
end