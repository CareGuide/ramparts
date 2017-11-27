# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'spam_parser/version'

Gem::Specification.new do |s|
  s.name        = 'spam_parser'
  s.version     = SpamParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Brent Scheibelhut', 'Careguide']
  s.email       = ['brent.scheibelhut@careguide.com', 'info@careguide.com']
  s.homepage    = 'https://github.com/CareGuide/spam_parser'
  s.summary     = %q{Parses blocks of text to find phone numbers (including phonetic numbers), emails, and bad url}
  s.description = %q{Parses blocks of text to find phone numbers (including phonetic numbers), emails, and bad url. Useful for finding scammers who tend to try to post their phone number in messages.}

  s.add_development_dependency 'rspec', '~> 2.5', '>= 2.5.0'
  s.add_development_dependency 'rubocop', '~>0.51.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end