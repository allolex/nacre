module Nacre
  class Order::AssignmentCollection

    include Enumerable

    attr_accessor :members

    def initialize(resource_hash = {})
      self.members = []
      resource_hash.each_pair do |key, value|
        members << Nacre::Order::Assignment.new(key, value)
      end
    end

    def each(&block)
      members.each do |member|
        block.call(member)
      end
    end

    def params
      members.map { |member| { member.key.to_sym => member.params } }
    end

  end
end
