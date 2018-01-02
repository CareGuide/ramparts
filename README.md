# Ramparts - Spam Detection ![Build Status](https://travis-ci.com/CareGuide/ramparts.svg?token=pzv1C7M8Vzq9xx1zxDRH&branch=master)
Parses blocks of text to find phone numbers (including phonetic numbers), emails, and spammer urls

## Example

Find obfuscated phone numbers

```
>> message = "Contact me directly ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."
>> Ramparts.find_phone_numbers(message)
[{start_offset: 22, end_offset: 71, type: :phone, value: 'FOUR ONE FIVE E I G H T 9 FOUR TOO EIGHT SIX FIVE'}]
```

Find obfuscated emails.

```
>> message = "Looking for honest worker .. contact ashley73299 AT yahoo dot com for more info"
>> Ramparts.find_emails(message)
[{start_offset: 37, end_offset: 65, type: :email, value: 'ashley73299 AT yahoo dot com'}]
```

Find both obfuscated emails and phone numbers.

```
>> message = "Looking for honest worker .. contact ashley73299 AT yahoo dot com or FOUR FIVE ONE 456 8900 for more info"
>> Ramparts.find_phone_numbers_and_emails(message)
[{start_offset: 37, end_offset: 65, type: :email, value: 'ashley73299 AT yahoo dot com'}, {start_offset: 70, end_offset: 92, type: :phone, value: 'FOUR FIVE ONE 456 8900'}]
```

Count the occurrences of well known spam URLs and keywords

```
>> message = ""cialis vs viagra spam guestbook.php?action=http://cialiswalmart.shop""
>> Ramparts.count_urls(message)
3
```

## API

#### count_phone_numbers(text, options = {})
- Returns the count of the number of phone numbers in the text. Currently uses a map reduce paradigm,
  which incurs information loss but is cleaner to implement, achieves better results, and is 
  **~2x faster** than `find_phone_numbers`
- **Input:**
    - text **[String]** 
    - options **[Hash]**
        - parse_leet **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain l33t syntax. With this set to true eg. `FivE 4 3 F0r On3 67 NiN3` would be caught.
        - remove_spaces **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain spaces between the numbers. With this set to true eg. `F i v E 4 3 F 0 r O n 3 67 N i N 3` would be caught.
- **Output:** 
    - number of occurrences of phone numbers **[Integer]**
- **Example**
    - **Input:** 
        - text &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `1`
    
#### find_phone_numbers(text, options = {})
- **Description:** Finds all occurrences of emails within a block of text. Even when l33t speak, phonetics and 
space variations are used.
- **Input:**
    - text **[String]** 
    - options **[Hash]**
        - To Be Implemented
- **Output:** 
    - **[Array]**
        - match **[Hash]**
            - offset: **[Integer]**
            - value: **[String]**
- **Example**
    - **Input:** 
        - text &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `[{start_offset: 84, end_offset: 133, type: :phone, value: 'FOUR ONE FIVE E I G H T 9 FOUR TOO EIGHT SIX FIVE'}]`

#### replace_phone_numbers(text, options = {}, &block)
- **Description:** Replaces all the occurrences of phone numbers within the text with what is returned in the block. Returns the redacted text.
of text.
- **Input:**
    - text **[String]** 
    - insertable **[String]**
    - options **[Hash]**
        - To Be Implemented
- **Output:** 
    - updated text **[String]**
- **Example**
    - **Usage:** `altered_text = replace_phone_numbers(...) do CENSORED end`
    - **Input:** 
        - text &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `"If you're interested in this position, do contact me directly on my phone number ( CENSORED  ). Hope you cracked that number code."`

#### count_emails(text, options = {})
- **Description:** Returns the count of the number of emails in the text. Currently uses a map reduce paradigm,
 which incurs information loss but is cleaner to implement, achieves better results, and is **~2x faster**
 than `find_emails`
 - **Input:**
     - text **[String]** 
     - options **[Hash]**
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
 - **Output:** 
     - number of occurences of emails **[Integer]**
 - **Example**
     - **Input:** 
         - text &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, I repeat ashley73299 @ yahoo . com ?.. Ashley"`
     - **Output:** `2`
 

#### find_emails(text, options = {})
- **Description:** Finds all occurrences of emails within a block of text. Even when l33t speak, phonetics are used.
- **Input:**
    - text **[String]** 
    - options **[Hash]**
        - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
        - check_for_at **[Boolean] [Default &rightarrow; `False`]**
            - checks for the word 'at' as '@', currently can result in algorithm being overly greedy as 'at' is such a common word
- **Output:**
    - **[Array]**
        - match **[Hash]**
            - offset: **[Integer]**
            - value: **[String]**
- **Example**
    - **Input:** 
        - text &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, I repeat ashley73299 @ yahoo . com ?.. Ashley"`
    - **Output:** `[{start_offset: 78, end_offset: 106, type: :email, value: 'ashley73299 AT yahoo dot com'}, {start_offset: 118, end_offset: 143, type: :email, value: 'ashley73299 @ yahoo . com'}]`

#### replace_emails(text, options = {}, &block)
- **Description:** Replaces all the occurrences of emails within the text with what is returned in the block. Returns the redacted text
of text.
- **Input:**
    - text **[String]**
    - options **[Hash]**
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
         - check_for_at **[Boolean] [Default &rightarrow; `False`]**
             - checks for the word 'at' as '@', currently can result in algorithm being overly greedy as 'at' is such a common word
- **Output:** 
    - updated text **[String]**   
- **Example**
    - **Usage:** `altered_text = replace_emails(...) do CENSORED end`
    - **Input:** 
        - text &rightarrow; `"My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbush042@gmail.com ) She will be waiting to hear from you kindly send her an email now!"`
    - **Output:** `My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( CENSORED ) She will be waiting to hear from you kindly send her an email now!`

#### count_phone_numbers_and_emails(text, options = {})
- **Description:** Returns the count of the number of emails in the text. Currently uses a map reduce paradigm,
 which incurs information loss but is cleaner to implement, achieves better results, and is **~2x faster**
 than `find_emails`
 - **Input:**
     - text **[String]** 
     - options **[Hash]**
         - parse_leet **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain l33t syntax. With this set to true eg. `FivE 4 3 F0r On3 67 NiN3` would be caught.
         - remove_spaces **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain spaces between the numbers. With this set to true eg. `F i v E 4 3 F 0 r O n 3 67 N i N 3` would be caught.
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
         - check_for_at **[Boolean] [Default &rightarrow; `False`]**
            - checks for the word 'at' as '@', currently can result in algorithm being overly greedy as 'at' is such a common word
 - **Output:** 
     - number of occurences of emails **[Integer]**
 - **Example**
     - **Input:** 
         - text &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, phone 416 090 78 NINE 5 ?.. Ashley"`
     - **Output:** `2`
 

#### find_phone_numbers_and_emails(text, options = {})
- **Description:** Finds all occurrences of phone numbers and emails within a block of text.
- **Input:**
    - text **[String]** 
    - options **[Hash]**
        - parse_leet **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain l33t syntax. With this set to true eg. `FivE 4 3 F0r On3 67 NiN3` would be caught.
        - remove_spaces **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain spaces between the numbers. With this set to true eg. `F i v E 4 3 F 0 r O n 3 67 N i N 3` would be caught.
        - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
        - check_for_at **[Boolean] [Default &rightarrow; `False`]**
            - checks for the word 'at' as '@', currently can result in algorithm being overly greedy as 'at' is such a common word
 - **Output:**
     - **[Array]**
        - match **[Hash]**
            - offset: **[Integer]**
            - value: **[String]**
- **Example**
    - **Input:** 
        - text &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, phone 416 090 78 NINE 5 ?.. Ashley"`
    - **Output:** `[{start_offset: 78, end_offset: 106, type: :email, value: 'ashley73299 AT yahoo dot com'}, {start_offset: 115, end_offset: 132, type: :phone, value: 'FOUR FIVE ONE 456 8900'}]`

#### replace_phone_numbers_and_emails(text, options = {}, &block)
- **Description:** Replaces all the occurrences of phone numbers and emails within the text with what is returned from the block. Returns the redacted text
of text.
- **Input:**
    - text **[String]**
    - options **[Hash]**
         - parse_leet **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain l33t syntax. With this set to true eg. `FivE 4 3 F0r On3 67 NiN3` would be caught.
         - remove_spaces **[Boolean][Default &rightarrow; True]**
            - Parses phone numbers that contain spaces between the numbers. With this set to true eg. `F i v E 4 3 F 0 r O n 3 67 N i N 3` would be caught.
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
         - check_for_at **[Boolean] [Default &rightarrow; `False`]**
             - checks for the word 'at' as '@', currently can result in algorithm being overly greedy as 'at' is such a common word
- **Output:** 
    - updated text **[String]**   
- **Example**
    - **Usage:** `altered_text = replace_phone_numbers_and_emails(...) do CENSORED end`
    - **Input:** 
        - text &rightarrow; `"My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbush042@gmail.com or FOUR FIVE ONE 789 4568 ) She will be waiting to hear from you kindly send her an email now!"`
    - **Output:** `My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( CENSORED or CENSORED ) She will be waiting to hear from you kindly send her an email now!`

#### count_urls(text, options = {})
- **Description:** Simple union regex to find if the text contains bad urls eg. viagra/cialis. Returns a count of the number of occurrences.
appear in the text.
- **Input:**
    - text **[String]** 
    - options **[Hash]**
        - To Be Implemented
 - **Output:** 
     - number of occurences of matches **[Integer]**
- **Example**
    - **Input:** 
        - text &rightarrow; `"cialis vs cialis spam guestbook.php?action=http://cialiswalmart.shop"`
    - **Output:** `3`

