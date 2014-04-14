require 'uri'
require 'json'
require 'nacre/order_search_results'
require 'nacre/abstract_resource'

module Nacre

  class Order < AbstractResource

    attribute :order_id
    attribute :parent_order_id
    attribute :order_type_id
    attribute :contact_id
    attribute :order_status_id
    attribute :order_stock_status_id
    attribute :created_on
    attribute :created_by_id
    attribute :customer_ref
    attribute :order_payment_status_id

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
        order_id: order['id'].to_i,
        parent_order_id: order['parentOrderId'].to_i
      }
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
