module Nacre
  class Journal::EntryCollection

    include Enumerable

    attr_accessor :members, :type

    def initialize(resource_list = [], options = {} )
      self.members = []
      self.type = options.fetch(:type)
      resource_list.each do |resource_params|
        members << Nacre::Journal::Entry.new(resource_params)
      end
    end

    def each(&block)
      members.each do |member|
        block.call(member)
      end
    end

    def params
      members.map(&:params)
    end

    def size
      members.size
    end
  end
end
