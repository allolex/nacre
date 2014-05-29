require 'nacre/abstract_resource_collection'

module Nacre

  class ProductCollection < AbstractResourceCollection

    private

    def self.resource_class
      Product
    end
  end
end
