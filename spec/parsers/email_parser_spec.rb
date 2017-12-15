# frozen_string_literal: true

require_relative '../data/email_data/truthy_email_data'
require_relative '../data/email_data/falsy_email_data'

describe '#count_emails' do
  it 'parses a number of positive test blocks correctly' do
    test_truthy_count(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails)
  end

  it 'parses a number of positive test blocks correctly with aggressive option' do
    test_truthy_count(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails, aggressive: true)
  end

  it 'parses a number of positive aggressive test blocks correctly with check_for_at option' do
    test_truthy_count(EMAIL_TRUTHY_AT, :count_emails, check_for_at: true)
  end

  it 'parses a number of positive aggressive test blocks correctly with aggressive option' do
    test_truthy_count(EMAIL_TRUTHY_AGGRESSIVE, :count_emails, aggressive: true)
  end

  it 'parses a number of negative test blocks correctly' do
    test_falsy_count(EMAIL_FALSY_BLOCKS, :count_emails)
  end
end

describe '#find_emails' do
  it 'finds a number of positive test blocks correctly' do
    test_truthy_finds(EMAIL_TRUTHY_WITH_ANSWERS, :find_emails)
  end

  it 'finds a number of positive aggressive test blocks correctly with check_for_at option' do
    test_truthy_finds(EMAIL_TRUTHY_AT, :find_emails, check_for_at: true)
  end

  # TODO: Update algorithm to be able to pass test with EMAIL_TRUTHY_AGGRESSIVE

  it 'finds a number of negative test blocks correctly and regex only' do
    test_falsy_finds(EMAIL_FALSY_BLOCKS, :find_emails)
  end
end

describe '#replace_emails' do
  it 'replaces a number of positive test blocks correctly with email replacer' do
    test_replacements(EMAIL_TRUTHY_WITH_ANSWERS, :replace_emails)
  end

  it 'replaces a number of positive aggressive test blocks correctly with check_for_at option' do
    test_replacements(EMAIL_TRUTHY_AT, :replace_emails, check_for_at: true)
  end

  # TODO: Update algorithm to be able to pass test with EMAIL_TRUTHY_AGGRESSIVE
end

describe 'Map/Reduce to Regex Run Time' do
  it 'times the two methods against each other' do
    compare_run_times(EMAIL_TRUTHY_WITH_ANSWERS, :count_emails, :find_emails)
  end
end
