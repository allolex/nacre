module Nacre
  class Order::PartyDetails < AbstractResource

    attribute :customer
    attribute :billing
    attribute :delivery

    def customer=(params)
      @customer = Order::Contact.new(params)
    end

    def billing=(params)
      @billing = Order::Contact.new(params)
    end

    def delivery=(params)
      @delivery = Order::Contact.new(params)
    end
  end
end
