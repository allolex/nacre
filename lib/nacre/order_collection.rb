require 'nacre/concerns/inflectible'

module Nacre

  class OrderCollection

    include Enumerable

    extend Inflectible

    attr_accessor :members

    def initialize(parametrized_orders = [])
      self.members = []
      parametrized_orders.each do |o|
        order_params = {
          id: o[:order_id],
          parent_order_id: o[:parent_order_id]
        }
        self.members << Order.new(order_params)
      end
    end

    def each &block
      members.each do |member|
        block.call(member)
      end
    end

    def self.from_json(json)
      orders = extract_orders(json)
      collection = new
      collection.members = orders.map { |o| Order.new( json_to_params(o) ) }
      collection
    end

    private

    def self.extract_orders(json)
      JSON.parse(json)['response']
    end

    def self.json_to_params(json_order)
      params = {}
      %w/id parentOrderId/.each do |key|
        params[snake_case(key).to_sym] = json_order[key]
      end
      params
    end
  end
end
