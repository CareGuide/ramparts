# frozen_string_literal: true

require 'pry'
require_relative '../../spec/data/email_data/list_of_email_domains'
require_relative './parsers/email_parser'
require_relative './parsers/phone_parser'
require_relative './parsers/url_parser'

# Parses text and indicates if possible spam based on variety of methods
def count_phone_numbers(block, options = {})
  pp = PhoneParser.new
  pp.count_phone_number_instances(block, options)
end

def replace_phone_numbers(block, insertable = 'cool', options = {})
  pp = PhoneParser.new
  pp.replace_phone_number_instances(block, insertable, options)
end

def find_phone_numbers(block, options = {})
  pp = PhoneParser.new
  pp.find_phone_number_instances(block, options)
end

def count_emails(block, options = {})
  ep = EmailParser.new
  ep.count_email_instances(block, options)
end

def replace_emails(block, insertable = 'hippy', options = {})
  ep = EmailParser.new
  ep.replace_email_instances(block, insertable, options)
end

def find_emails(block, options = {})
  ep = EmailParser.new
  ep.find_email_instances(block, options)
end

def count_urls(block)
  up = UrlParser.new
  up.count_url_instances(block)
end
