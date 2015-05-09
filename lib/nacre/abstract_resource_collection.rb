require 'nacre/concerns/inflectible'

module Nacre

  class AbstractResourceCollection < AbstractCollection

    include Enumerable
    extend Inflectible
    extend Getable

    attr_accessor :members

    def initialize(parametrized_resources = [])
      self.members = []
      parametrized_resources.each do |r|
        resource_params = normalize_params(r)
        self.members << self.class.resource_class.new(resource_params)
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
      collection.members = resources.map { |r| resource_class.new( json_to_params(r) ) }
      collection
    end

    private

    def normalize_params(params)
      resource_params = params
      id_key = "#{self.class.resource_name}_id".to_sym
      resource_params[:id] = params[id_key]
      resource_params.delete(id_key)
      resource_params
    end

    def self.extract_resources(json)
      JSON.parse(json)['response']
    end

    def self.json_to_params(json_order)
      format_hash_keys(json_order)
    end
  end
end
