require 'nacre/abstract_collection'

module Nacre
  class Order::AssignmentCollection < AbstractCollection

    private

    def resource_class
      Nacre::Order::Assignment
    end

  end
end
