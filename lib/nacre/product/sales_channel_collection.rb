module Nacre
  class Product::SalesChannelCollection

    include Enumerable
    extend Inflectible

    attr_accessor :members

    def initialize(resource_list = [])
      self.members = []
      resource_list.each do |resource_params|
        members << Nacre::Product::SalesChannel.new(resource_params)
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

    def product_name
      name_sources = members.select do |member|
        member.sales_channel_name == 'Brightpearl'
      end

      if name_sources.empty?
        nil
      else
        name_sources.first.product_name
      end
    end

  end
end
