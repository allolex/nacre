require 'nacre/abstract_collection'

module Nacre
  class Order::RowCollection < AbstractCollection

    private

    def resource_class
      Nacre::Order::Row
    end
  end
end
