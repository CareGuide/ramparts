module PhoneParser
  def find_phone_number(block)
    block.downcase.gsub(/[^0-9,one,two,three,four,five,six,seven,eight,nine,ten,zero,oh,o]/, "")
  end
end