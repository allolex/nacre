require 'uri'
require 'json'
require 'nacre/order_search_results'
require 'nacre/concerns/inflectible'

module Nacre

  class Order

    extend Inflectible

    attr_reader :id, :parent_order_id

    def initialize(options = {})
      @id = options[:id].to_s
      @parent_order_id = options[:parent_order_id].to_s
    end

    def self.find(id_list = [])
      response = link.get(self.search_url)
      Nacre::OrderSearchResults.from_json(response.body)
    end

    def self.from_json(json)
      params = orders_from_json(json)
      new(params)
    end

    private

    def self.orders_from_json(json)
      order = JSON.parse(json)['response'].first
      {
        id: order['id'],
        parent_order_id: order['parentOrderId']
      }
    end

    def self.build_uri(query, options)
      "#{search_url}?#{escape_query(query)}#{options}"
    end

    def self.escape_query(query)
      if query.nil?
        ''
      else
        URI.escape(query + '&')
      end
    end

    def self.service_url
      configuration.base_url + '/order-service'
    end

    def self.url
      service_url + '/order'
    end

    def self.search_url
      service_url + '/order-search'
    end

    def self.link
      Nacre.link
    end

    def self.configuration
      Nacre.configuration
    end
  end
end
