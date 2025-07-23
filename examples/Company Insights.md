# Company Insights With Ruby

Finds company details such as revenue, size, founding year, public status, etc. [Outscraper API](https://app.outscraper.cloud/api-docs#tag/Other-Services/paths/~1company-insights/get).

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
# Get information about the companies:
results = client.company_insights('outscraper.com')
```
