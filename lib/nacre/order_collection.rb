require 'nacre/abstract_resource_collection'

module Nacre

  class OrderCollection < AbstractResourceCollection

    private

    def self.resource_class
      Order
    end
  end
end
