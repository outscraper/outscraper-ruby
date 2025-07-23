# Youtube Comments Scraper With Ruby

Returns comments from YouTube videos.[Outscraper API](https://app.outscraper.cloud/api-docs#tag/Reviews-and-Comments/paths/~1youtube-comments/get).

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
# Get information about the comments from YouTube videos:
results = client.youtube_comments('https://www.youtube.com/watch?v=ph5pHgklaZ0')
```
