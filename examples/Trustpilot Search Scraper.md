# Trustpilot Search Scraper With Ruby

Returns search results from Trustpilot. [Outscraper API](https://app.outscraper.cloud/api-docs#tag/Trustpilot/paths/~1trustpilot~1search/get).


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
# Get information about the search results from Trustpilot:
results = client.trustpilot_search('real estate')
```
