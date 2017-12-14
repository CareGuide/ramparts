# frozen_string_literal: true

require './lib/ramparts'
require_relative '../data/url_data/truthy_url_data'
require_relative '../data/url_data/falsy_url_data'

describe '#count_urls' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_count(URL_TRUTHY, :count_urls)
  end

  it 'parses a number of negative test blocks correctly' do
    test_falsy_count(URL_FALSY, :count_urls)
  end
end
