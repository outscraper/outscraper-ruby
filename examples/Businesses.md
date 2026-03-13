# Businesses Search With Ruby

The library provides real-time access to business records via the [Outscraper API](https://app.outscraper.com/api-docs).
It supports classic structured filters and AI-powered plain-text queries for flexible search.

- Structured search using `filters`, `fields`, `limit`, and other parameters
- AI-powered search using the `query` parameter
- Combined mode where structured params and `query` are merged by the server

---

## Installation

Install the gem and add it to the application's Gemfile by executing:

```bash
bundle add outscraper
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install outscraper
```

[Link to the Ruby package page](https://rubygems.org/gems/outscraper)

---

## Initialization

```ruby
require "outscraper"

client = Outscraper::Client.new("SECRET_API_KEY")
```

[Link to the profile page to create the API key](https://app.outscraper.com/profile)

---

## Usage

### Search businesses with structured filters

```ruby
results = client.businessesSearch(
  filters: {
    country_code: "US",
    states: ["NY"],
    cities: ["New York", "Buffalo"],
    types: ["restaurant", "cafe"],
    has_website: true,
    has_phone: true,
    business_statuses: ["operational"]
  },
  limit: 50,
  include_total: false,
  fields: ["name", "phone", "website", "address", "rating", "reviews"]
)

puts results
```

### Search businesses with AI plain-text query

```ruby
results = client.businessesSearch(
  query: "Find cafes in New York, NY. Limit 25. Return name, address, phone, website, rating and reviews."
)

puts results
```

### Combine structured params and plain-text query

```ruby
results = client.businessesSearch(
  filters: {
    country_code: "US",
    states: ["CA"],
    types: ["restaurant"]
  },
  fields: ["name", "phone"],
  limit: 15,
  query: "Add cafes too. Return address and reviews. Limit 20. Include total."
)

puts results
```

When both structured params and `query` are provided:

- `filters` and `fields` are merged
- for `limit`, `cursor`, and `include_total`, plain-text values take priority when present
- if a value is not specified, API defaults are used

### Search businesses with enrichments

`enrichments` can be provided in three formats:

- **Hash (recommended)** — send a structured object with options per enrichment
- **Array** — enable enrichments without options
- **String** — enable a single enrichment without options

#### Enrichments as Hash (recommended)

```ruby
results = client.businessesSearch(
  filters: {
    country_code: "US",
    states: ["CA", "NY"],
    types: ["restaurant", "cafe"]
  },
  limit: 10,
  fields: ["name", "phone", "website", "rating", "reviews"],
  enrichments: {
    "contacts_n_leads" => {
      "contacts_per_company" => 4,
      "emails_per_contact" => 2
    },
    "company_insights" => {}
  }
)

puts results
```

#### Enrichments as Array

```ruby
results = client.businessesSearch(
  filters: { country_code: "US", states: ["NY"] },
  limit: 10,
  enrichments: ["contacts_n_leads", "company_insights"]
)

puts results
```

#### Enrichments as String

```ruby
results = client.businessesSearch(
  filters: { country_code: "US", states: ["NY"] },
  limit: 10,
  enrichments: "contacts_n_leads"
)

puts results
```

#### Full JSON-style parameters example

```ruby
params = {
  filters: {
    country_code: "US",
    states: ["CA", "NY"],
    types: ["restaurant", "cafe"]
  },
  limit: 900,
  cursor: nil,
  include_total: false,
  fields: [
    "name", "types", "address", "country", "website",
    "phone", "rating", "reviews"
  ],
  enrichments: {
    "contacts_n_leads" => {
      "contacts_per_company" => 4,
      "emails_per_contact" => 2
    },
    "company_insights" => {}
  },
  query: "Find hotels in California and Illinois with rating 4.2+ and status operational. Return fields: name, address, rating and reviews. Limit results to 6. Enrich data with contacts_n_leads. Contact per company set to 8"
}

results = client.businessesSearch(**params)
puts results
```

### Iterate through all results (auto-pagination)

```ruby
items = client.businessesIterSearch(
  filters: {
    country_code: "US",
    states: ["NY"],
    business_statuses: ["operational"]
  },
  limit: 100,
  fields: ["name", "phone", "address", "rating", "reviews"]
)

puts items.length
```

### Get business details by ID

```ruby
business = client.businessesGet(
  "YOUR_BUSINESS_ID",
  fields: ["name", "phone", "website", "address", "rating", "reviews"]
)

puts business
```
