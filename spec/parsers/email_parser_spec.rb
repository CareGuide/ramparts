# frozen_string_literal: true

require './lib/ramparts'
require_relative '../spec_helper_methods'
require_relative '../data/email_data/truthy_email_data'
require_relative '../data/email_data/falsy_email_data'

describe '#count_emails' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_count(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails)
  end

  it 'parses a number of positive test blocks correctly with aggressive option' do
    test_truthy_count(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails, aggressive: true)
  end

  it 'parses a number of positive aggressive test blocks correctly with aggressive option' do
    test_truthy_count(EMAIL_TRUTHY_AGGRESSIVE, :count_emails, aggressive: true)
  end

  it 'parses a number of negative test blocks correctly' do
    test_falsy_count(EMAIL_FALSY_BLOCKS, :count_emails)
  end
end

describe '#find_emails' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_finds(EMAIL_TRUTHY_WITH_ANSWERS, :find_emails)
  end

  # TODO: Both test blocks, but passing with the aggressive option and regex only

  it 'parses a number of negative test blocks correctly and regex only' do
    test_falsy_finds(EMAIL_FALSY_BLOCKS, :find_emails)
  end
end

describe 'Map/Reduce to Regex Run Time' do
  it 'times the two methods against each other' do
    compare_run_times(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails, :find_emails)
  end
end
