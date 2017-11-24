# frozen_string_literal: true

# Parses text and attempts to locate email
class EmailParser
  def find_email_instances(block, options)
    block = parse_email(block)
    instances = []
    if options.fetch(:aggressive, false)
      temp_instances =
        block
        .enum_for(:scan, ALLOWABLE_WITHOUT_DOT_REGEX)
        .map { [Regexp.last_match.begin(0), Regexp.last_match.to_s] }
      temp_instances.each do |instance|
        instances << instance if EMAIL_DOMAINS.any? { |domain| instance[1].split('@')[1].include? domain }
      end
    else
      instances = block.enum_for(:scan, ALLOWABLE_REGEX).map { [Regexp.last_match.begin(0), Regexp.last_match.to_s] }
    end
    instances
  end

  private

  ALLOWABLE_REGEX = Regexp.new(/[a-z0-9._%+-]+\${,2}@{1}\${,2}[a-z0-9.-]+\${,2}(\.){1}/)
  ALLOWABLE_WITHOUT_DOT_REGEX = Regexp.new(/[a-z0-9._%+-]+\${,2}@{1}\${,2}[a-z0-9.-]+\${,2}/)

  REPLACEMENTS = {
    ' at ' => '@',
    '(at)' => '@',
    ' dot ' => '.'
  }.freeze

  def parse_email(block)
    block.downcase.gsub(/\ at\ |\(at\)|\ dot\ /, REPLACEMENTS).gsub(/[^\w\@\.\_\%\+\-]/, '$')
  end
end
