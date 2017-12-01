# frozen_string_literal: true

require_relative './parsers/email_parser'
require_relative './parsers/phone_parser'
require_relative './parsers/url_parser'

class SpamParser
  def self.count_phone_numbers(block, options = {})
    pp = PhoneParser.new
    pp.count_phone_number_instances(block, options)
  end

  def self.replace_phone_numbers(block, insertable = 'cool', options = {})
    pp = PhoneParser.new
    pp.replace_phone_number_instances(block, insertable, options)
  end

  def self.find_phone_numbers(block, options = {})
    pp = PhoneParser.new
    pp.find_phone_number_instances(block, options)
  end

  def self.count_emails(block, options = {})
    ep = EmailParser.new
    ep.count_email_instances(block, options)
  end

  def self.replace_emails(block, insertable = 'hippy', options = {})
    ep = EmailParser.new
    ep.replace_email_instances(block, insertable, options)
  end

  def self.find_emails(block, options = {})
    ep = EmailParser.new
    ep.find_email_instances(block, options)
  end

  def self.count_urls(block, options = {})
    up = UrlParser.new
    up.count_url_instances(block, options)
  end
end
