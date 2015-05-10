require "nacre/abstract_resource"
require "nacre/concerns/searchable"

module Nacre
  class Product < AbstractResource

    extend Searchable
    extend Getable

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

    def self.resource_class
      self
    end

    def identity=(params)
      @identity = Product::Identity.new(params)
    end

    def sales_channels=(channels_list)
      @sales_channels = Product::SalesChannelCollection.new(channels_list)
    end

    def financial_details=(params)
      @financial_details = Product::FinancialDetails.new(params)
    end

    def stock=(params)
      @stock = Product::StockDetails.new(params)
    end

    def custom_fields=(hash)
      @custom_fields = hash unless hash.nil? || hash.empty?
    end

    def null_custom_fields=(list)
      @null_custom_fields = list unless list.nil? || list.empty?
    end

    def sku
      identity.sku
    end

    def barcode
      identity.barcode
    end

    def name
      return nil if sales_channels.nil?
      sales_channels.product_name
    end
  end
end
