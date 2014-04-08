module Nacre
  class Product::SalesChannelCollection

    include Enumerable
    extend Inflectible

    attr_accessor :members

    def initialize(resource_list = [])
      self.members = []
      resource_list.each do |resource_params|
        self.members << Product::SalesChannel.new(resource_params)
      end
    end

    def each(&block)
      self.members.each do |member|
        block.call(member)
      end
    end

    def params
      self.members.map(&:params)
    end

  end
end
