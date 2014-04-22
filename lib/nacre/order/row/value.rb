require 'nacre/concerns/amountable'

module Nacre
  class Order::Row::Value < AbstractResource

    include Amountable

    attribute :tax_code
    attribute :tax_rate
    attribute :row_tax
    attribute :row_net

    def tax_rate=(value)
      @tax_rate = protect_number(value)
    end

    def tax_rate
      return nil if blank?(@tax_rate)
      '%.6f' % [unprotect_number(@tax_rate)]
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
