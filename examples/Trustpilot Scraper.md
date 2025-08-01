# Trustpilot Scraper With Ruby

Returns data from Trustpilot businesses. [Outscraper API](https://app.outscraper.cloud/api-docs#tag/Businesses-and-POI/paths/~1trustpilot/get).

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
# Search data from Trustpilot businesses:
results = client.trustpilot('outscraper.com')
```
