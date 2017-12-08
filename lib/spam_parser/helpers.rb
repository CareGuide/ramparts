# frozen_string_literal: true

ARGUMENT_ERROR_TEXT = 'Parameter 1, the block of text to parse, is not a string'

# The map reduce (MR) algorithm. Faster by ~2x than the other algorithm.
# Maps parts of the text such as 'at' or 'FOUR' down to '@' and '4'
# removes spaces etc, and then runs a simple regex over the remainder
# Information loss occurs and hence it can't return indices
MR_ALGO = 'MR'

# The glorified regex (GR) algorithm.
# An obtuse and yet heartily strong regex that does a single pass over
# the text. Since the regex is so complicated and robust - it is slower
# than the map reduce algorithm. No information loss occurs
# so we can return indices of where the phone numbers and etc. exist
GR_ALGO = 'GR'
