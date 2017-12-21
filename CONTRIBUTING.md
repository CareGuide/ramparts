# Contributing

Everyone is welcome to contribute to Ramparts. Contributing doesn’t just mean submitting pull requests—there are many different ways for you to get involved, including answering questions, reporting or triaging [issues](https://github.com/CareGuide/ramparts/issues), et al.

No matter how you want to get involved, we ask that you be kind, and treat others on the project with respect.

We love pull requests. We'd like to at least comment on, if not
accept, pull requests within a few days. We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Make sure the tests pass (this includes linting)
* Update the documentation: code comments, example code, guides. Basically,
  update everything affected by your contribution.
* Include any information that would be relevant to reproducing bugs, use cases for new features, etc.
* If the change does break compatibility, how can it be updated to become backwards compatible, while directing users to the new way of doing things?
* A suitable and well thought throught commit message

# Branch Naming

Please follow the following naming convention for branch names. Use `-` to separate words.

- Use `feature/...` for feature related changes
- Use `fix/...` for changes that fix a bug
- Use `refactor/...` for general refactors of the code (eg. cleaning the code, adding comments)
- Finally use `update/...` for general updates that aren't refactors or bug fixes but aren't major enough to fall under features

# Testing

Run linting tests on your branch simply by typing `rubocop` when within the top level directory

Run general unit tests simply by typing `rspec` when within the top level directory

When writing tests please have the [first three digits](https://en.wikipedia.org/wiki/555_(telephone_number)) (not the area code) of phone numbers as `555` (or the phonetic/l33t equivalent) to avoid collisions with actual phone numbers

Please also use `example` for the domain of test email addresses for a similar reason

# Stale issue and pull request policy

Issues and pull requests have a shelf life and sometimes they are no longer relevant. All issues and pull requests that have not had any activity for 60 days will be marked as `stale`. Simply leave a comment with information about why it may still be relevant to keep it open. If no activity occurs in the next 7 days, the issue will be automatically closed. Stale PR's will be closed manually.

The goal of this process is to keep the list of open issues and pull requests focused on work that is actionable and important for the maintainers and the community.

# Pull Request Reviews & releasing

Once pull request has been given approval, leadership will realease and deploy the gem (See [Roadmap](https://github.com/CareGuide/ramparts/blob/master/ROADMAP.md)) for automatic deploys)