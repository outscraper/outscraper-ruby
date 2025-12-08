# Emails And Contacts Scraper With Ruby

Returns directions between two points from Google Maps. [Outscraper API](https://app.outscraper.cloud/api-docs#tag/Google/paths/~1maps~1directions/get).

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
# Returns directions:
results = client.google_maps_directions(['29.696596, 76.994928    30.7159662444353, 76.8053887016268', '29.696596, 76.994928    30.723065, 76.770169'])
```
