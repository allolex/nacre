require "nacre/abstract_collection"

module Nacre
  class Order::AssignmentCollection < AbstractCollection

    def current
      members.select { |assignment| assignment.key == :current }.first
    end

    def self.resource_class
      Nacre::Order::Assignment
    end

  end
end
