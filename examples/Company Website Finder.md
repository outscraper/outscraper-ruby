# Company Website Finder With Ruby

Finds company websites based on business names.[Outscraper API](https://app.outscraper.cloud/api-docs#tag/Domain-Related/paths/~1company-website-finder/get).

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
results = client.company_website_finder('Apple Inc')
```
