# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "phone-parser/version"

Gem::Specification.new do |s|
  s.name        = "phone_parser"
  s.version     = PhoneParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brent Scheibelhut", "Careguide"]
  s.email       = ["brent.scheibelhut@careguide.com", "info@careguide.com"]
  s.homepage    = "https://github.com/CareGuide/phone_parser"
  s.summary     = %q{Parses blocks of text to find phone numbers, including phonetic numbers}
  s.description = %q{Parses blocks of text to find phone numbers, including phonetic numbers. Useful for finding scammers who tend to try to post their phone number in messages.}

  # s.add_runtime_dependency "launchy"
  s.add_development_dependency "rspec", "~>2.5.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end