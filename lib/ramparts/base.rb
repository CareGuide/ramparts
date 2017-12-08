# frozen_string_literal: true

require_relative './parsers/email_parser'
require_relative './parsers/phone_parser'
require_relative './parsers/url_parser'

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
end
