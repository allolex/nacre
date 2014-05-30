require 'nacre/abstract_collection'

module Nacre
  class Order::AssignmentCollection < AbstractCollection

    def self.resource_class
      Nacre::Order::Assignment
    end

  end
end
