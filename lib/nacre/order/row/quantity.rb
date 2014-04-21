module Nacre
  class Order::Row::Quantity < AbstractResource

    attribute :magnitude

    def magnitude=(value)
      @magnitude = value.to_f
    end

    def magnitude
      '%0.6f' % [@magnitude]
    end

  end
end
