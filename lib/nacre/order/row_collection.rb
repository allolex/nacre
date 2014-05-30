require 'nacre/abstract_collection'

module Nacre
  class Order::RowCollection < AbstractCollection

    def self.resource_class
      Nacre::Order::Row
    end
  end
end
