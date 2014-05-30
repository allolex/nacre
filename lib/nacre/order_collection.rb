require 'nacre/abstract_resource_collection'

module Nacre

  class OrderCollection < AbstractResourceCollection

    def self.resource_class
      Order
    end
  end
end
