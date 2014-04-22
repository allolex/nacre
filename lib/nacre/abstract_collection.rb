module Nacre
  class AbstractCollection

    include Enumerable

    attr_accessor :members

    def initialize(resource_hash = {})
      self.members = []
      resource_hash.each_pair do |key, value|
        members << resource_class.new(key, value)
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

    private

    def resource_class
      raise 'Calling class must define .collection_class'
    end
  end
end
