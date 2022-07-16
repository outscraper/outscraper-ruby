# frozen_string_literal: true

require "httparty"

require_relative "outscraper/version"

module Outscraper
  class Client
    include HTTParty
    base_uri 'https://api.app.outscraper.com'

    def initialize(api_key)
      self.class.headers 'X-API-KEY' => api_key
    end

    def google_search(query, pages_per_query: 1, uule: '', language: 'en', region: nil)
      response = self.class.get("/google-search-v2", 'query': {
        query: query,
        pagesPerQuery: pages_per_query,
        uule: uule,
        language: language,
        region: region,
        async: false,
      }).parsed_response['data']
    end

    def google_maps_search_v2(query, limit: 20, drop_duplicates: false, language: 'en', region: nil, skip: 0)
      response = self.class.get("/maps/search-v2", 'query': {
        query: query,
        limit: limit,
        drop_duplicates: drop_duplicates,
        language: language,
        region: region,
        skipPlaces: skip,
        async: false,
      }).parsed_response['data']
    end

    def google_maps_reviews_v3(query, reviews_limit: 10, limit: 1, sort: 'most_relevant', skip: 0, start: 0, cutoff: 0, cutoff_rating: 0, ignore_empty: false, language: 'en', region: nil, reviews_query: nil)
      response = self.class.get("/maps/reviews-v3", 'query': {
        query: query,
        reviewsLimit: reviews_limit,
        limit: limit,
        sort: sort,
        skip: skip,
        start: start,
        cutoff: cutoff,
        reviewsQuery: reviews_query,
        cutoffRating: cutoff_rating,
        ignoreEmpty: ignore_empty,
        language: language,
        region: region,
        async: false,
      }).parsed_response['data']
    end

    def emails_and_contacts(query)
      response = self.class.get("/emails-and-contacts", 'query': {
        query: query,
        async: false,
      }).parsed_response['data']
    end

    def phones_enricher(query)
      response = self.class.get("/phones-enricher", 'query': {
        query: query,
        async: false,
      }).parsed_response['data']
    end
  end
end
