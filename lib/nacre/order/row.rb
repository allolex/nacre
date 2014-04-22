module Nacre
  class Order::Row < AbstractResource

    attribute :product_sku
    attribute :product_options
    attribute :quantity
    attribute :product_id
    attribute :product_name
    attribute :nominal_code
    attribute :order_row_sequence
    attribute :composition
    attribute :row_value
    attribute :tax_rate

    attr_accessor :key

    def initialize(key, options = {})
      self.key = key
      self.attributes = options
    end

    def product_options=(params)
      @product_options = Order::Row::ProductOptions.new(params)
    end

    def quantity=(params)
      @quantity = Order::Row::Quantity.new(params)
    end

    def composition=(params)
      @composition = Order::Row::CompositionDetails.new(params)
    end

    def row_value=(params)
      @row_value = Order::Row::Value.new(params)
    end
  end
end
