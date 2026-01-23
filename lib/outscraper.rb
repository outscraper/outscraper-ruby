# frozen_string_literal: true

require "httparty"
require "cgi"
require "json"

require_relative "outscraper/version"

QUERY_DELIMITER = '    '

def format_direction_queries(q)
  if q.is_a?(Array) && !q.empty? && q.first.is_a?(Array)
    return q.map { |pair| pair.join(QUERY_DELIMITER) }
  end

  return q if q.is_a?(Array)

  [q]
end


module Outscraper
  class Client
    include HTTParty
    base_uri 'https://api.app.outscraper.com'

    def initialize(api_key)
      self.class.headers 'X-API-KEY' => api_key, 'Accept-Encoding' => 'utf-8'
    end

    def google_search(query, pages_per_query: 1, uule: '', language: 'en', region: nil)
      response = self.class.get("/google-search-v3", 'query': {
        query: query,
        pagesPerQuery: pages_per_query,
        uule: uule,
        language: language,
        region: region,
        async: false,
      }).parsed_response['data']
    end

    def google_search_news(query, pages_per_query: 1, uule: '', tbs: '', language: 'en', region: nil, async_request: false)
      response = self.class.get('/google-search-news', query: {
        query: query,
        pagesPerQuery: pages_per_query,
        uule: uule,
        tbs: tbs,
        language: language,
        region: region,
        async: async_request
      }).parsed_response['data']
    end

    def google_maps_search(query, limit: 20, drop_duplicates: false, language: 'en', region: nil, skip: 0)
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

    def google_maps_search_v3(query, limit: 20, language: 'en', region: nil, skip: 0, drop_duplicates: false, enrichment: nil, async_request: true)
      response = self.class.get('/maps/search-v3', query: {
        query: query,
        language: language,
        region: region,
        organizationsPerQueryLimit: limit,
        skipPlaces: skip,
        dropDuplicates: drop_duplicates,
        enrichment: enrichment ? Array(enrichment) : nil,
        async: async_request
      }).parsed_response['data']
    end

    def google_maps_directions(query:, departure_time: nil, finish_time: nil, interval: nil, travel_mode: 'best', language: 'en', region: nil, fields: nil, async_request: true)
      queries = format_direction_queries(query)
      response = self.class.get('/maps/directions', query: {
        query: queries,
        departure_time: departure_time,
        finish_time: finish_time,
        interval: interval,
        travel_mode: travel_mode,
        language: language,
        region: region,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def google_maps_reviews(query, reviews_limit: 10, limit: 1, sort: 'most_relevant', skip: 0, start: 0, cutoff: 0, cutoff_rating: 0, ignore_empty: false, language: 'en', region: nil, reviews_query: nil)
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

    def get_google_maps_photos(query, options = {})
      response = self.class.get('/maps/photos-v3', query: {
        query: query,
        photosLimit: options[:photosLimit] || 100,
        limit: options[:limit] || 1,
        tag: options[:tag] || 'all',
        language: options[:language] || 'en',
        region: options[:region],
        fields: options[:fields],
        async: options.key?(:async) ? options[:async] : true,
        ui: options[:ui] || false,
        webhook: options[:webhook]
      }).parsed_response['data']
    end

    def google_play_reviews(query, reviews_limit: 100, sort: 'most_relevant', cutoff: nil, rating: nil, language: 'en', fields: nil, async_request: false)
      response = self.class.get('/google-play/reviews', query: {
        query: query,
        limit: reviews_limit,
        sort: sort,
        cutoff: cutoff,
        rating: rating,
        language: language,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def contacts_and_leads(
      query,
      fields: nil,
      async_request: true,
      preferred_contacts: nil,
      contacts_per_company: 3,
      emails_per_contact: 1,
      skip_contacts: 0,
      general_emails: false,
      ui: false,
      webhook: nil
    )
      response = self.class.get('/contacts-and-leads', query: {
        query: query,
        fields: fields ? Array(fields) : nil,
        async: ui ? true : async_request,
        preferred_contacts: preferred_contacts ? Array(preferred_contacts) : nil,
        contacts_per_company: contacts_per_company,
        emails_per_contact: emails_per_contact,
        skip_contacts: skip_contacts,
        general_emails: general_emails,
        ui: ui,
        webhook: webhook
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

    def amazon_products(query, limit: 24, domain: 'amazon.com', postal_code: '11201', fields: nil, async_request: false)
      response = self.class.get('/amazon/products-v2', query: {
        query: query,
        limit: limit,
        domain: domain,
        postal_code: postal_code,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def amazon_reviews(query, limit: 10, sort: 'helpful', filter_by_reviewer: 'all_reviews', filter_by_star: 'all_stars', domain: nil, fields: nil, async_request: false)
      response = self.class.get('/amazon/reviews', query: {
        query: query,
        limit: limit,
        sort: sort,
        filterByReviewer: filter_by_reviewer,
        filterByStar: filter_by_star,
        domain: domain,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def yelp_search(query, limit: 100, async_request: false)
      response = self.class.get('/yelp-search', query: {
        query: query,
        limit: limit,
        async: async_request
      }).parsed_response['data']
    end

    def yelp_reviews(query, limit: 100, cursor: '', sort: 'relevance_desc', cutoff: '', fields: '', async_request: false)
      response = self.class.get('/yelp/reviews', query: {
        query: query,
        limit: limit,
        cursor: cursor,
        sort: sort,
        cutoff: cutoff,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def tripadvisor_reviews(query, limit: 100, async_request: false)
      response = self.class.get('/tripadvisor-reviews', query: {
        query: query,
        limit: limit,
        async: async_request
      }).parsed_response['data']
    end

    def app_store_reviews(query, limit: 100, sort: 'mosthelpful', cutoff: nil, fields: '', async_request: false)
      response = self.class.get('/appstore/reviews', query: {
        query: query,
        limit: limit,
        sort: sort,
        cutoff: cutoff,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def youtube_comments(query, per_query: 100, language: 'en', region: '', fields: '', async_request: false)
      response = self.class.get('/youtube-comments', query: {
        query: query,
        perQuery: per_query,
        language: language,
        region: region,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def g2_reviews(query, limit: 100, sort: '', cutoff: nil, fields: nil, async_request: false)
      response = self.class.get('/g2/reviews', query: {
        query: query,
        limit: limit,
        sort: sort,
        cutoff: cutoff,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def trustpilot_reviews(query, limit: 100, languages: 'default', sort: '', cutoff: nil, fields: '', async_request: false)
      response = self.class.get('/trustpilot/reviews', query: {
        query: query,
        limit: limit,
        languages: languages,
        sort: sort,
        cutoff: cutoff,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def glassdoor_reviews(query, limit: 100, sort: 'DATE', cutoff: nil, async_request: false)
      response = self.class.get('/glassdoor/reviews', query: {
        query: query,
        limit: limit,
        sort: sort,
        cutoff: cutoff,
        async: async_request
      }).parsed_response['data']
    end

    def capterra_reviews(query, limit: 100, sort: '', cutoff: nil, language: 'en', region: nil, fields: nil, async_request: false)
      response = self.class.get('/capterra-reviews', query: {
        query: query,
        limit: limit,
        sort: sort,
        cutoff: cutoff,
        language: language,
        region: region,
        async: async_request,
        fields: fields ? Array(fields) : nil
      }).parsed_response['data']
    end

    def geocoding(query, async_request: false)
      response = self.class.get('/geocoding', query: {
        query: query,
        async: async_request
      }).parsed_response['data']
    end

    def reverse_geocoding(query, async_request: false)
      response = self.class.get('/reverse-geocoding', query: {
        query: query,
        async: async_request
      }).parsed_response['data']
    end

    def phone_identity_finder(query, async_request: false)
      response = self.class.get('/whitepages-phones', query: {
        query: query.is_a?(Array) ? query : [query],
        async: async_request
      }).parsed_response['data']
    end

    def address_scraper(query, async_request: false)
      response = self.class.get('/whitepages-addresses', query: {
        query: query.is_a?(Array) ? query : [query],
        async: async_request
      }).parsed_response['data']
    end

    def company_insights(query, fields: '', async_request: false, enrichments: [])
      response = self.class.get('/company-insights', query: {
        query: query.is_a?(Array) ? query : [query],
        fields: fields,
        enrichments: enrichments.is_a?(Array) ? enrichments : [enrichments],
        async: async_request
      }).parsed_response['data']
    end

    def validate_emails(query, async_request: false)
      response = self.class.get('/email-validator', query: {
        query: query.is_a?(Array) ? query : [query],
        async: async_request
      }).parsed_response['data']
    end

    def trustpilot(query, enrichment: [], fields: '', async_request: false)
      enrichment_array = enrichment ? (enrichment.is_a?(Array) ? enrichment : [enrichment]) : []
      response = self.class.get('/trustpilot', query: {
        query: query.is_a?(Array) ? query : [query],
        enrichment: enrichment_array,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def trustpilot_search(query, limit: 100, skip: 0, enrichment: [], fields: '', async_request: false)
      enrichment_array = enrichment.is_a?(Array) ? enrichment : [enrichment]
      response = self.class.get('/trustpilot', query: {
        query: query.is_a?(Array) ? query : [query],
        limit: limit,
        skip: skip,
        enrichment: enrichment_array,
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def similarweb(query, fields: '', async_request: false)
      response = self.class.get('/similarweb', query: {
        query: query.is_a?(Array) ? query : [query],
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end

    def company_website_finder(query, fields: '', async_request: false)
      response = self.class.get('/company-website-finder', query: {
        query: query.is_a?(Array) ? query : [query],
        fields: fields,
        async: async_request
      }).parsed_response['data']
    end
    
    def yellowpages_search(query, location: 'New York, NY', limit: 100, region: nil, enrichment: [], fields: '', async_request: false, ui: nil, webhook: nil)
      enrichment_array = enrichment.is_a?(Array) ? enrichment : [enrichment]
      response = self.class.get('/yellowpages-search', query: {
        query: query.is_a?(Array) ? query : [query],
        location: location,
        limit: limit,
        region: region,
        enrichment: enrichment_array,
        fields: fields,
        async: async_request,
        ui: ui,
        webhook: webhook
      }).parsed_response['data']
    end

    def postAPIRequest(path, parameters = {})
      payload = parameters || {}

      response = self.class.post(
        path,
        headers: { 'Content-Type' => 'application/json' },
        body: payload.to_json
      ).parsed_response

      response.is_a?(Hash) && response.key?('data') ? response['data'] : response
    end

    def businessesSearch(
      filters: {},
      limit: 10,
      include_total: false,
      cursor: nil,
      fields: nil,
      async_request: false,
      ui: false,
      webhook: nil
    )
      payload = {
        filters: (filters || {}),
        limit: limit,
        include_total: include_total,
        cursor: cursor,
        fields: fields ? Array(fields) : nil,
        async: async_request,
        ui: ui,
        webhook: webhook
      }.compact

      postAPIRequest('/businesses', payload)
    end

    def businessesIterSearch(filters: {}, limit: 10, fields: nil, include_total: false)
      cursor = nil
      all_items = []

      loop do
        page = businessesSearch(
          filters: filters,
          limit: limit,
          include_total: include_total,
          cursor: cursor,
          fields: fields,
          async_request: false
        )

        items = page.is_a?(Hash) ? (page['items'] || []) : []
        break if !items.is_a?(Array) || items.empty?

        all_items.concat(items)

        has_more = !!(page['has_more'])
        next_cursor = page['next_cursor']
        break if !has_more || next_cursor.nil? || next_cursor.to_s.strip.empty?

        cursor = next_cursor.to_s
      end

      all_items
    end

    def businessesGetDetails(business_id, fields: nil, async_request: false, ui: false, webhook: nil)
      raise ArgumentError, 'business_id is required' if business_id.nil? || business_id.to_s.strip.empty?

      fields_param =
        if fields.is_a?(Array)
          fields.map(&:to_s).join(',')
        else
          fields
        end

      response = self.class.get("/businesses/#{CGI.escape(business_id.to_s)}", query: {
        fields: fields_param,
        async: async_request,
        ui: ui,
        webhook: webhook
      }.compact).parsed_response
      response.is_a?(Hash) && response.key?('data') ? response['data'] : response
    end
  end
end
