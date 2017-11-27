# Spam Parser
Parses blocks of text to find phone numbers ()including phonetic numbers), emails, and urls

## API

**count_phone_numbers(block, options = {})**
- Returns the count of the number of phone numbers in the block. Currently uses a map reduce paradigm,
 which incurs information loss but also is cleaner to implement and currently achieves better results

**replace_phone_numbers(block, insertable = 'cool', options = {})**
- Currently has no implementation

**find_phone_numbers(block, options = {})**
- A substantial Regex, will handle all the usual cases, plus when the users  attempt to use `at`, `dot` and space
variations. Currently does not fully capture emails such as `gloria at yahoo dot co dot uk` but it's on track to
achieve this soon
- Example return value: `[[100, 'jbush@gmail.com'], [143, 'candace at yahoo dot com']]`

**count_emails(block, options = {})**
- Returns the count of the number of emails in the block. Currently uses a map reduce paradigm,
 which incurs information loss but also is cleaner to implement and currently achieves better results

**replace_emails(block, insertable = 'hippy', options = {})**
- Currently no implemented

**find_emails(block, options = {})**
- A substantial Regex, will handle all the usual cases, plus when the users  attempt to use leet speak, phonetics and 
space variations. Currently does not fully capture emails such as `S I X O N E F I V E` but it's on track to
achieve this soon
- Example return value: `[[100, 'FOUR ONE EIGHT TWO NINE ZERO 2 Five'], [143, '4.1.6.4.5.3.2.8.9.0']]`
**Note:** Please do not use options yet on the method, they're in a transition state

**count_urls(block)**
- Simple union regex to find if the text contains bad urls eg. viagra/cialis. Returns a count of how many occurences
appear in the text
