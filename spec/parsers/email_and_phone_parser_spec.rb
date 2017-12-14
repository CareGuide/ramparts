# frozen_string_literal: true

require_relative '../data/email_and_phone_data/truthy_email_and_phone_data'
require_relative '../data/email_and_phone_data/falsy_email_and_phone_data'

describe '#count_phone_numbers_and_emails' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_count(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers_and_emails)
  end

  it 'parses a number of negative test blocks correctly' do
    test_falsy_count(EMAIL_PHONE_FALSY_BLOCKS, :count_phone_numbers)
  end
end

describe '#find_phone_numbers_and_emails' do
  it 'parses a number of positive test blocks correctly with multi method' do
    test_truthy_finds(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :find_phone_numbers_and_emails)
  end

  it 'parses a number of positive test blocks correctly with multi method and compare option' do
    test_truthy_finds(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :find_phone_numbers_and_emails, compare: true)
  end

  it 'parses a number of negative test blocks correctly with multi method' do
    test_falsy_finds(EMAIL_PHONE_FALSY_BLOCKS, :find_phone_numbers_and_emails)
  end
end

describe '#replace_phone_numbers_and_emails' do
  it 'replaces a number of positive test blocks correctly with multi method' do
    test_replacements(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :replace_phone_numbers_and_emails)
  end

  it 'replaces a number of positive test blocks correctly with multi method and compare option' do
    test_replacements(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :replace_phone_numbers_and_emails, compare: true)
  end
end

describe 'Map/Reduce to Regex Run Time' do
  it 'times the two methods against each other' do
    compare_run_times(EMAIL_PHONE_TRUTHY_WITH_ANSWERS, :count_phone_numbers_and_emails, :find_phone_numbers_and_emails)
  end
end
