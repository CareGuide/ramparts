# Spam Parser
Parses blocks of text to find phone numbers (including phonetic numbers), emails, and spammer urls

## Example

Find obfuscated phone numbers

```
>> message = "Contact me directly ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."
>> SpamParser.find_phone_numbers(message)
[[100, 'FOUR ONE FIVE E I G H T 9 FOUR TOO EIGHT SIX FIVE']]
```

Find obfuscated emails

```
>> message = "Looking for honest worker .. contact ashley73299 AT yahoo dot com for more info"
>> SpamParser.find_emails(message)
[[73, 'ashley73299 AT yahoo dot com']]
```

Count the occurrences of well known spam URLs and keywords

```
>> message = ""cialis vs viagra spam guestbook.php?action=http://cialiswalmart.shop""
>> SpamParser.count_urls(message)
3
```


## API

#### count_phone_numbers(block, options = {})
- Returns the count of the number of phone numbers in the block. Currently uses a map reduce paradigm,
  which incurs information loss but is cleaner to implement, achieves better results, and is 
  **~2x faster** than `find_phone_numbers`
- **Input:**
    - block **[String]** 
    - options **[Hash]**
        - parse_leet **[Boolean][Default &rightarrow; False]**
            - Parses phone numbers that contain l33t syntax. With this set to true eg. `FivE 4 3 F0r On3 67 NiN3` would be caught.
        - remove_spaces **[Boolean][Default &rightarrow; False]**
            - Parses phone numbers that contain spaces between the numbers. With this set to true eg. `F i v E 4 3 F 0 r O n 3 67 N i N 3` would be caught.
- **Output:** 
    - **[Integer]**
- **Example**
    - **Input:** 
        - block &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `1`

#### replace_phone_numbers(block, insertable, options = {})
- **Description:** Replaces all the occurrences of phone numbers within the block with `insertable`. Returns the redacted block
of text.
- **Input:**
    - block **[String]** 
    - options **[Hash]**
        - To Be Implemented
 - **Output:** 
     - value **[Integer]**
- **Example**
    - **Input:** 
        - block &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `[[100, 'FOUR ONE FIVE E I G H T 9 FOUR TOO EIGHT SIX FIVE']]`

#### find_phone_numbers(block, options = {})
- **Description:** Finds all occurrences of emails within a block of text. Even when l33t speak, phonetics and 
space variations are used.
- **Input:**
    - block **[String]** 
    - options **[Hash]**
        - To Be Implemented
 - **Output:** 
     - **[Array]**
        - **[Array]**
            - **[Integer]**
            - **[String]**
- **Example**
    - **Input:** 
        - block &rightarrow; `"If you're interested in this position, do contact me directly on my phone number ( FOUR ONE FIVE E I G H T 9 FOUR TWO EIGHT SIX FIVE  ). Hope you cracked that number code."`
    - **Output:** `[[100, 'FOUR ONE FIVE E I G H T 9 FOUR TOO EIGHT SIX FIVE']]`

#### count_emails(block, options = {})
- **Description:** Returns the count of the number of emails in the block. Currently uses a map reduce paradigm,
 which incurs information loss but is cleaner to implement, achieves better results, and is **~2x faster**
 than `find_emails`
 - **Input:**
     - block **[String]** 
     - options **[Hash]**
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
 - **Output:** 
     - **[Integer]**
 - **Example**
     - **Input:** 
         - block &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, I repeat ashley73299 @ yahoo . com ?.. Ashley"`
     - **Output:** `2`
 

#### find_emails(block, options = {})
- **Description:** Finds all occurrences of emails within a block of text. Even when l33t speak, phonetics are used.
- **Input:**
    - block **[String]** 
    - options **[Hash]**
        - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
 - **Output:** 
     - **[Array]**
        - **[Array]**
            - **[Integer]**
            - **[String]**
- **Example**
    - **Input:** 
        - block &rightarrow; `"Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley73299 AT yahoo dot com, I repeat ashley73299 @ yahoo . com ?.. Ashley"`
    - **Output:** `[[100, 'ashley73299 AT yahoo dot com'], [143, 'ashley73299 @ yahoo . com']]`

#### replace_emails(block, insertable, options = {})
- **Description:** Replaces all the occurrences of emails within the block with `insertable`. Returns the redacted block
of text.
- **Input:**
    - block **[String]** 
    - options **[Hash]**
         - aggressive **[Boolean] [Default &rightarrow; `False`]**
            - doesn't require a `.` or `dot` + a TLD at the end, but instead compares the last word against a well known list of email domains (eg. `contact ashley @ yandex for more info` would be caught)
- **Output:** 
    - **[String]**   
- **Example**
    - **Input:** 
        - block &rightarrow; `"My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbush042@gmail.com ) She will be waiting to hear from you kindly send her an email now!"`
        - insertable &rightarrow; `"CENSORED"`
    - **Output:** `My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( CENSORED ) She will be waiting to hear from you kindly send her an email now!`

#### count_urls(block, options = {})
- **Description:** Simple union regex to find if the text contains bad urls eg. viagra/cialis. Returns a count of the number of occurrences.
appear in the text.
- **Input:**
    - block **[String]** 
    - options **[Hash]**
        - To Be Implemented
 - **Output:** 
     - **[Integer]**
- **Example**
    - **Input:** 
        - block &rightarrow; `"cialis vs cialis spam guestbook.php?action=http://cialiswalmart.shop"`
    - **Output:** `3`

