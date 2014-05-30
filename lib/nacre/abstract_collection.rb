require 'nacre/concerns/resourceable'

module Nacre
  class AbstractCollection

    extend Resourceable
    include Enumerable

    attr_accessor :members

    def initialize(resource_hash = {})
      self.members = []
      resource_hash.each_pair do |key, value|
        members << self.class.resource_class.new(key, value)
      end
    end

    def each(&block)
      members.each do |member|
        block.call(member)
      end
    end

    def params
      res = {}
      members.each { |member| res[member.key] = member.params }
      res
    end

    def self.resource_class
      raise NotImplementedError, "Subclass #{self.name} must implement .#{__method__}"
    end
  end
end
