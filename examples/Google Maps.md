# Google Maps Scraper With Ruby

The library provides real-time access to the places from Google Maps via [Outscraper API](https://app.outscraper.com/api-docs#tag/Google-Maps).

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
# Search for businesses in specific locations:
results = client.google_maps_search('restaurants brooklyn usa', limit: 20, language: 'en', region: 'us')

# Get data of the specific place by id
results = client.google_maps_search('ChIJrc9T9fpYwokRdvjYRHT8nI4', language: 'en')
```
