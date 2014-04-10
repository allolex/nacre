require 'nacre/abstract_resource'

module Nacre
  class Product < AbstractResource

    extend Inflectible

    attribute :product_id
    attribute :brand_id
    attribute :product_type_id
    attribute :identity
    attribute :product_group_id
    attribute :stock
    attribute :financial_details
    attribute :sales_channels
    attribute :composition
    attribute :variations
    attribute :custom_fields
    attribute :null_custom_fields

    def self.from_json(json)
      params = params_from_json(json)
      new(params)
    end

    def identity=(params)
      @identity = Nacre::Product::Identity.new(params)
    end

    def sales_channels=(channels_list)
      @sales_channels = Nacre::Product::SalesChannelCollection.new(channels_list)
    end

    def financial_details=(params)
      @financial_details = Nacre::Product::FinancialDetails.new(params)
    end

    def stock=(params)
      @stock = Nacre::Product::StockDetails.new(params)
    end

    def custom_fields=(hash)
      @custom_fields = hash unless hash.nil? || hash.empty?
    end

    def null_custom_fields=(list)
      @null_custom_fields = list unless list.nil? || list.empty?
    end

    # TODO: Shouldn't this be using Nacre::Response instead of Faraday::Response?
    def self.get(range)
      request_url = build_request_url(url,range,resource_options)
      response = self.link.get(request_url)
      Nacre::Product.from_json(response.body)
    end

    private

    def self.build_request_url(url, query, options)
      "#{url}/#{query.to_s}?#{options}"
    end

    def self.resource_options
      'includeOptional=customFields,nullCustomFields'
    end

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first

      params = {}
      resource.each_pair do |camel_key,value|
        if camel_key == 'id'
          params[:product_id] = value
        else
          params[snake_case(camel_key).to_sym] = value
        end
      end
      params
    end

    def self.service_url
      configuration.resource_url + '/product-service'
    end

    def self.url
      service_url + '/product'
    end

    def self.link
      Nacre.link
    end

    def self.configuration
      Nacre.configuration
    end
  end
end
