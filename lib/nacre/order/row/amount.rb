module Nacre
  class Order::Row::Amount < AbstractResource

    attribute :value
    attribute :currency_code

    # Values are stored to six significant decimal places
    def value=(amount)
      @value = (amount.to_f * 1000000).to_i
    end

    def value
      '%0.6f' % [(@value / 1000000).to_f]
    end

    def value_raw
      @value
    end

  end
end
