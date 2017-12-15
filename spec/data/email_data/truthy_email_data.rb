# frozen_string_literal: true

require_relative '../../spec_constants'

EMAIL_TRUTHY_WITH_ANSWERS = [
  {
    matches: ["jbash042@gmail.com"],
    text: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbash042@gmail.com ) She will be waiting to hear from you kindly send her an email now!",
    filtered: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) She will be waiting to hear from you kindly send her an email now!"
  },
  {
    matches: ["Virginiak002@aol.com"],
    text: "Hello dear. My name is Virginia,I'm currently in Texas but in process of moving to your area,I read your profile on nannylane.com and will like to have you as my sons nanny. Starting from on the 27 of November,9AM-1PM,Mon-Fri or on weekends basis.They are 5&1+ years respectively,i am willing to pay $20/hr am sure these is good for you,just because i want the best care for my sons.Email me your resume/references to (Virginiak002@aol.com) for more details,Hope to read from you soon",
    filtered:  "Hello dear. My name is Virginia,I'm currently in Texas but in process of moving to your area,I read your profile on nannylane.com and will like to have you as my sons nanny. Starting from on the 27 of November,9AM-1PM,Mon-Fri or on weekends basis.They are 5&1+ years respectively,i am willing to pay $20/hr am sure these is good for you,just because i want the best care for my sons.Email me your resume/references to (#{INSERTABLE}) for more details,Hope to read from you soon"
  },
  {
    matches: ["jbash042@gmail.com", "flavourjames at  yandex dot com"],
    text: "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( jbash042@gmail.com ) She will be waiting to hear from you kindly send her an email now! flavourjames at  yandex dot com",
    filtered:  "My name is Cynthia, a friend of mine needs a nanny to watch her baby in your area, her contact is ( #{INSERTABLE} ) She will be waiting to hear from you kindly send her an email now! #{INSERTABLE}"
  },
  {
    matches: ["ashley72299 AT yahoo dot co dot uk"],
    text: "Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is ashley72299 AT yahoo dot co dot uk . Am available and will like to know the amount you charge per hr ?.. Ashley",
    filtered:  "Hi, Are you seriously interested ..Looking for honest worker .. My e-mail is #{INSERTABLE} . Am available and will like to know the amount you charge per hr ?.. Ashley"
  },
  {
    matches: ["MichaelZachary817 at gmail dot com"],
    text: "Hi, Are you a baby sitter? If yes,I am in need of a babysitter/Nanny for my 3 yr old daughter clara,If you are interested, Kindly contact me for more information on MichaelZachary817 at gmail dot com for me details of the Job.",
    filtered:  "Hi, Are you a baby sitter? If yes,I am in need of a babysitter/Nanny for my 3 yr old daughter clara,If you are interested, Kindly contact me for more information on #{INSERTABLE} for me details of the Job."
  },
  {
    matches: ["josepamela1200 at gmail.com"],
    text: "Hello, My name is Pamela, I read your profile on sitter.com on the possition of nanny, and i would like you to have you in taking care of my son, am always busy due to work issues and other housing issues, this job starting from 30th of November. I'm willing to pay $30/hour, 9am-1pm, Mondays-Thursdays 'or' 9am- 4pm Weekend basis, you can send me an email confirming your interest, or email me with your resume at (josepamela1200 at gmail.com) to know your qualification, and your passion for the job. will be glad to work with you, await your email Thanks. Pamela",
    filtered:  "Hello, My name is Pamela, I read your profile on sitter.com on the possition of nanny, and i would like you to have you in taking care of my son, am always busy due to work issues and other housing issues, this job starting from 30th of November. I'm willing to pay $30/hour, 9am-1pm, Mondays-Thursdays 'or' 9am- 4pm Weekend basis, you can send me an email confirming your interest, or email me with your resume at (#{INSERTABLE}) to know your qualification, and your passion for the job. will be glad to work with you, await your email Thanks. Pamela"
  },
  {
    matches: ["flavorjames0022 AT gmail DOT com"],
    text: "I am moving down to your town and i need responsible pet sitting service for my American bulldog,Plz i want you to just email me now to get more details from me with days hours and weekly payment and my email is [flavorjames0022 AT gmail DOT com ]i want you to make sure you email me with your callphone number and i will be paying 300 bucks weeky.",
    filtered:  "I am moving down to your town and i need responsible pet sitting service for my American bulldog,Plz i want you to just email me now to get more details from me with days hours and weekly payment and my email is [#{INSERTABLE} ]i want you to make sure you email me with your callphone number and i will be paying 300 bucks weeky."
  },
  {
    matches: ["emmalineflouress1104 AT outlook DOT com"],
    text: "I am moving down to your town and I need responsible pet sitter service for my American bulldog ,plz I want you to just email me now to get more details from me with days hours and weekly payment and my email is(emmalineflouress1104 AT outlook DOT com ) I want you to make sure you email me with your cellphone number and I will be paying $300 weekly.Flores.",
    filtered:  "I am moving down to your town and I need responsible pet sitter service for my American bulldog ,plz I want you to just email me now to get more details from me with days hours and weekly payment and my email is(#{INSERTABLE} ) I want you to make sure you email me with your cellphone number and I will be paying $300 weekly.Flores."
  },
  {
    matches: ["rosefale at yandex dot com"],
    text: "Hi Felicia! I saw your profile and I'm looking for someone that will care for my son David and make him happy, he's 9 years old lovely and fun to be with, i will offer $20 per hr. We are responsible and easy going family.Send your resume or your availability to my email address so that i can tell you more about what i want for my son. E-mail me on rosefale at yandex dot com",
    filtered:  "Hi Felicia! I saw your profile and I'm looking for someone that will care for my son David and make him happy, he's 9 years old lovely and fun to be with, i will offer $20 per hr. We are responsible and easy going family.Send your resume or your availability to my email address so that i can tell you more about what i want for my son. E-mail me on #{INSERTABLE}"
  }
].freeze

EMAIL_TRUTHY_AGGRESSIVE = [
  {
    matches: ["w i l l h o l d 1 1 (at) gmail"],
    text: "Hello Detra. I saw that you are looking for a home owner. I think that we would be a good match. shoot me a message at w i l l h o l d 1 1 (at) gmail",
    filtered:  "Hello Detra. I saw that you are looking for a home owner. I think that we would be a good match. shoot me a message at w i l l h o l d 1 1 (at) gmail"
  }
].freeze
