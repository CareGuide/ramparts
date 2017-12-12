# frozen_string_literal: false

ARGUMENT_ERROR_TEXT = 'Parameter 1, the block of text to parse, is not a string'.freeze

# The map reduce (MR) algorithm. Faster by ~2x than the other algorithm.
# Maps parts of the text such as 'at' or 'FOUR' down to '@' and '4'
# removes spaces etc, and then runs a simple regex over the remainder
# Information loss occurs and hence it can't return indices
MR_ALGO = 'MR'.freeze

# The glorified regex (GR) algorithm.
# An obtuse and yet heartily strong regex that does a single pass over
# the text. Since the regex is so complicated and robust - it is slower
# than the map reduce algorithm. No information loss occurs
# so we can return indices of where the phone numbers and etc. exist
GR_ALGO = 'GR'.freeze

# Given some text it replaces each matched instance with the given insertable
def replace(text, insertable, instances)
  altered_text = String.new(text)

  instances.map do |instance|
    altered_text[instance[:start_offset]...instance[:end_offset]] = insertable
  end
  altered_text
end

# Given some text it scans the text with the given regex for matches
def scan(text, regex, type)
  text
    .enum_for(:scan, regex)
    .map do
      {
        start_offset: Regexp.last_match.begin(0),
        end_offset: Regexp.last_match.begin(0) + Regexp.last_match.to_s.length,
        value: Regexp.last_match.to_s,
        type: type
      }
    end
end

# Check if two ranges overlap
def ranges_overlap?(r1, r2)
  r1.cover?(r2.first) || r2.cover?(r1.first)
end
