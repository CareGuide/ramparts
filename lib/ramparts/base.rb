# frozen_string_literal: true

require_relative './parsers/email_parser'
require_relative './parsers/phone_parser'
require_relative './parsers/url_parser'
require_relative './helpers'

class Ramparts
  def self.count_phone_numbers(text, options = {})
    pp = PhoneParser.new
    pp.count_phone_number_instances(text, options)
  end

  def self.replace_phone_numbers(text, insertable, options = {})
    pp = PhoneParser.new
    pp.replace_phone_number_instances(text, insertable, options)
  end

  def self.find_phone_numbers(text, options = {})
    pp = PhoneParser.new
    pp.find_phone_number_instances(text, options)
  end

  def self.count_emails(text, options = {})
    ep = EmailParser.new
    ep.count_email_instances(text, options)
  end

  def self.replace_emails(text, insertable, options = {})
    ep = EmailParser.new
    ep.replace_email_instances(text, insertable, options)
  end

  def self.find_emails(text, options = {})
    ep = EmailParser.new
    ep.find_email_instances(text, options)
  end

  def self.count_urls(text, options = {})
    up = UrlParser.new
    up.count_url_instances(text, options)
  end

  def self.count_phone_numbers_and_emails(text, options = {})
    pp = PhoneParser.new
    ep = EmailParser.new

    phone_instances = pp.count_phone_number_instances(text, options)
    email_instances = ep.count_email_instances(text, options)
    phone_instances + email_instances
  end

  def self.find_phone_numbers_and_emails(text, options = {})
    pp = PhoneParser.new
    ep = EmailParser.new

    phone_instances = pp.find_phone_number_instances(text, options)
    email_instances = ep.find_email_instances(text, options)

    if options.fetch(:compare, false)
      phone_instances.each do |phone|
        phone_range = (phone[:start_offset]...phone[:end_offset])
        email_instances.delete_if do |email|
          email_range = (email[:start_offset]...email[:end_offset])
          ranges_overlap?(phone_range, email_range)
        end
      end
    end

    phone_instances + email_instances
  end

  def self.replace_phone_numbers_and_emails(text, insertable, options = {})
    pp = PhoneParser.new
    ep = EmailParser.new

    phone_instances = pp.find_phone_number_instances(text, options)
    email_instances = ep.find_email_instances(text, options)
    total_instances = phone_instances + email_instances

    if options.fetch(:compare, false)
      phone_instances.each do |phone|
        phone_range = (phone[:start_offset]...phone[:end_offset])
        email_instances.delete_if do |email|
          email_range = (email[:start_offset]...email[:end_offset])
          ranges_overlap?(phone_range, email_range)
        end
      end
    end

    # We have no idea the order of the matches unless we ran the regex for both occurrences at the same time.
    # Instead we sort by start offset and then reverse so that we can replace from the end of the
    # string to the start to not screw up indices. Apparently this is the fastest way to sort in reverse
    # https://stackoverflow.com/questions/2642182/sorting-an-array-in-descending-order-in-ruby#answer-2651028
    total_instances_sorted = total_instances.sort_by { |instance| instance[:start_offset] }.reverse!

    replace(text, insertable, total_instances_sorted)
  end
end
