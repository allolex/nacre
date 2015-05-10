require "nacre/abstract_resource"

module Nacre
  class Product::StockDetails < AbstractResource

    attribute :stock_tracked

    def stock_tracked=(value)
      @stock_tracked = value.to_s == "true" ? true : false
    end

  end
end
