require 'nacre/concerns/inflectible'

module Nacre

  class ProductCollection < AbstractCollection

    include Enumerable
    extend Inflectible
    extend Getable

    attr_accessor :members

    def initialize(parametrized_resources = [])
      self.members = []
      parametrized_resources.each do |r|
        params = {
          id: r[:product_id]
        }
        self.members << self.class.resource_class.new(params)
      end
    end

    def each(&block)
      members.each do |member|
        block.call(member)
      end
    end

    def self.from_json(json)
      resources = extract_resources(json)
      collection = new
      collection.members = resources.map { |r| self.resource_class.new( json_to_params(r) ) }
      collection
    end

    private

    def self.resource_class
      Product
    end

    def self.extract_resources(json)
      JSON.parse(json)['response']
    end

    def self.json_to_params(json_order)
      params = {}
      %w/id/.each do |key|
        params[snake_case(key).to_sym] = json_order[key]
      end
      params
    end

  end
end
