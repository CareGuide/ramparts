require "lib/phone_parser"

TEST_BLOCK_1 = "I need a babysitter and errand for my son textme direct on my number if you are interested 3.2.3.4.3.8.4.8.3.8"
TEST_BLOCK_2 = "Hi Felicia! I saw that you are looking for a family. Would you like to chat sometime soon?(862) 256-4170"
TEST_BLOCK_3 = "If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE EIGHT NINE FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."

describe PhoneParser do
  it "parses block 1" do
    expect(PhoneParser.find_phone_number(TEST_BLOCK_1)).to eql("3234384838")
  end
end