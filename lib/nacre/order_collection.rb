module Nacre

  class OrderCollection

    include Enumerable

    attr_reader :members

    def initialize(json)
      orders = extract_orders(json)
      @members = orders.map { |o| Order.new(o) }
    end

    def each &block
      members.each do |member|
        block.call(member)
      end
    end

    private


    def extract_orders(json)
      JSON.parse(json)['response']
    end
  end
end
