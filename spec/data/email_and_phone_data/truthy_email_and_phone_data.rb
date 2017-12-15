# frozen_string_literal: true

require_relative '../../spec_constants'

# Please place phone number answers first for testing
# It shouldn't matter if we implemented stronger test matchers
EMAIL_PHONE_TRUTHY_WITH_ANSWERS = [
  {
    matches: ["jbash042@gmail.com"],
    text: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbash042@gmail.com ) She will be waiting to hear from you kindly send her an email now!",
    filtered: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) She will be waiting to hear from you kindly send her an email now!"
  },
  {
    matches: ["555.213.FOUR FIVE EIGHT NINE", "jbash042@gmail.com"],
    text: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbash042@gmail.com ) or 555.213.FOUR FIVE EIGHT NINE!",
    filtered: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) or #{INSERTABLE}!"
  },
  {
    matches: ["555-545-5454", "johnkrueger@johnson.com"],
    text: "You can contact me at johnkrueger@johnson.com, or call me at 555-545-5454. Please get in touch.",
    filtered: "You can contact me at #{INSERTABLE}, or call me at #{INSERTABLE}. Please get in touch."
  },
  {
    matches: ["416-545-5454", "john.krueger@johnson.com"],
    text: "You can contact me at john.krueger@johnson.com, or call me at 416-545-5454. Please get in touch.",
    filtered: "You can contact me at #{INSERTABLE}, or call me at #{INSERTABLE}. Please get in touch."
  },
  {
    matches: ["416-545-5454", "john.krueger@johnson.com"],
    text: "You can contact me at john.krueger@johnson.com, or call me at 416-545-5454. Please get in touch.",
    filtered: "You can contact me at #{INSERTABLE}, or call me at #{INSERTABLE}. Please get in touch."
  }
].freeze
