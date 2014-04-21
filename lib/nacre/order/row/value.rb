module Nacre
  class Order::Row::Value < AbstractResource

    attribute :tax_code
    attribute :tax_rate
    attribute :row_tax
    attribute :row_net

    def tax_rate=(value)
      @tax_rate = (value.to_f * 1000000).to_i
    end

    def tax_rate
      "%.6f" % [(@tax_rate / 1000000).to_f]
    end

    def tax_rate_raw
      @tax_rate
    end

    def row_tax=(params)
      @row_tax = Order::Row::Amount.new(params)
    end

    def row_net=(params)
      @row_net = Order::Row::Amount.new(params)
    end
  end
end
