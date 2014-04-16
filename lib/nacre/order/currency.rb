module Nacre
  class Order::Currency < AbstractResource

    attribute :exchange_rate
    attribute :order_currency_code
    attribute :accounting_currency_code

  end
end
