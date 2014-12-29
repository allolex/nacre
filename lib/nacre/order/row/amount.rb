require 'nacre/concerns/amountable'

module Nacre
  class Order::Row::Amount < AbstractResource

    include Amountable

    attribute :value
    attribute :currency_code

    def value=(amount)
      @value = protect_number(amount)
    end

    def value
      "%0.#{decimal_places}f" % [unprotect_number(@value)]
    end

    def value_raw
      @value
    end

    private

    def decimal_places
      Nacre.configuration.value_precision
    end
  end
end
