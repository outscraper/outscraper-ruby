# Tripadvisor Reviews Scraper With Ruby

Returns reviews from Tripadvisor businesses.
In case no reviews were found by your search criteria, your search request will consume the usage of one review. [Outscraper API](https://app.outscraper.cloud/api-docs#tag/Reviews-and-Comments/paths/~1tripadvisor-reviews/get).

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
# Get information about business:
results = client.tripadvisor_reviews('https://www.tripadvisor.com Restaurant_Review-g187147-d12947099-Reviews-Mayfair_Garden-Paris_Ile_de_France.html')
```
