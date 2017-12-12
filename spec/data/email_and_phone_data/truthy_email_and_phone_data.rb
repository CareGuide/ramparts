# frozen_string_literal: true

require_relative '../../spec_helper_methods'

# Please place phone number answers first for testing
# It shouldn't matter if we implemented stronger test matchers
EMAIL_PHONE_TRUTHY_WITH_ANSWERS = [
  [["jbush042@gmail.com"], "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbush042@gmail.com ) She will be waiting to hear from you kindly send her an email now!", "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) She will be waiting to hear from you kindly send her an email now!"],
  [["416.233.FOUR FIVE EIGHT NINE", "jbush042@gmail.com"], "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbush042@gmail.com ) or 416.233.FOUR FIVE EIGHT NINE!", "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) or #{INSERTABLE}!"],
  [["416-555-5454", "john@johnson.com"], "You can contact me at john@johnson.com, or call me at 416-555-5454. Please get in touch.", "You can contact me at #{INSERTABLE}, or call me at #{INSERTABLE}. Please get in touch."]
].freeze
