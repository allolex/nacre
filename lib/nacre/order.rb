require 'uri'
require 'json'
require 'nacre/order_search_results'
require 'nacre/concerns/matchable'

module Nacre

  class Order

    FIELDS = [
      :order_id,
      :parent_order_id,
      :order_type_id,
      :contact_id,
      :order_status_id,
      :order_stock_status_id,
      :created_on,
      :created_by_id,
      :customer_ref,
      :order_payment_status_id
    ]

    include Matchable

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(options = {})
      FIELDS.each do |attrib|
        self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
      end
    end

    def self.find(id_list = [])
      response = link.get(self.search_url)
      Nacre::OrderSearchResults.from_json(response.body)
    end

    def self.from_json(json)
      params = orders_from_json(json)
      new(params)
    end

    def params
      params = {}
      FIELDS.each do |key|
        params[key] = "#{self.send(key.to_s)}"
      end
      params
    end

    private

    def self.orders_from_json(json)
      order = JSON.parse(json)['response'].first
      {
        order_id: order['id'].to_i,
        parent_order_id: order['parentOrderId'].to_i
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
      configuration.resource_url + '/order-service'
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
