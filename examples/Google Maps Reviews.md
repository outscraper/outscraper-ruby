# Google Maps Reviews Scraper With Ruby

The library provides real-time access to the reviews from Google Maps via [Outscraper API](https://app.outscraper.com/api-docs#tag/Google-Reviews).

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
# Get reviews of the specific place by id
results = client.google_maps_reviews_v3('ChIJrc9T9fpYwokRdvjYRHT8nI4', reviews_limit: 20, language: 'en')

# Get reviews for places found by search query
results = client.google_maps_reviews_v3('Memphis Seoul brooklyn usa', reviews_limit: 20, limit: 500, language: 'en')

# Get only new reviews during last 24 hours
yesterday_timestamp = 1657980986

results = client.google_maps_reviews_v3(
    'ChIJrc9T9fpYwokRdvjYRHT8nI4', sort: 'newest', cutoff: yesterday_timestamp, reviews_limit: 100, language: 'en')
```
