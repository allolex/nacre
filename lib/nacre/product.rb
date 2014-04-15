require 'nacre/abstract_resource'

module Nacre
  class Product < AbstractResource


    attribute :id
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

    def name
      sales_channels.product_name
    end

    private

    def self.resource_options
      'includeOptional=customFields,nullCustomFields'
    end

  end
end
