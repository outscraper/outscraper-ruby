# Google Search Results Scraper With Ruby

The library returns search results from Google based on a given search query via [Outscraper API](https://app.outscraper.com/api-docs#tag/Google-Search).

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
# Search for SERP results:
result = client.google_search('buy iphone 13 TX', language: 'en', region: 'us')
```
