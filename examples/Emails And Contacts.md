# Emails And Contacts Scraper With Ruby

Allows finding email addresses, social links, and phones from domains via [Outscraper API](https://app.outscraper.com/api-docs#tag/Emails-and-Contacts).

## Installation

Install the gem and add to the application's Gemfile by executing:
```bash
bundle add outscraper
```

If bundler is not being used to manage dependencies, install the gem by executing:
```bash
gem install outscraper
```

[Link to the Ruby package page](https://rubygems.org/gems/outscraper)

## Initialization
```ruby
require 'Outscraper'

client = Outscraper::Client.new('SECRET_API_KEY')
```
[Link to the profile page to create the API key](https://app.outscraper.com/profile)

## Usage

```ruby
# Search contacts from website:
results = client.emails_and_contacts('outscraper.com')
```
