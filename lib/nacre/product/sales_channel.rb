require 'nacre/abstract_resource'

module Nacre
  class Product::SalesChannel < AbstractResource

    attribute :sales_channel_name
    attribute :product_name
    attribute :product_condition
    attribute :categories
    attribute :description
    attribute :short_description

    def description=(options = {})
      @description = Product::Description.new(options)
    end

    def short_description=(options = {})
      @short_description = Product::Description.new(options)
    end
  end
end
