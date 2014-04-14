module Nacre
  class Product::SalesChannelCollection

    include Enumerable
    extend Inflectible

    attr_accessor :members

    def initialize(resource_list = [])
      self.members = []
      resource_list.each do |resource_params|
        self.members << Nacre::Product::SalesChannel.new(resource_params)
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

    def product_name
      name_sources = self.members.select { |member| member.sales_channel_name == 'Brightpearl' }
      if name_sources.empty?
        nil
      else
        name_sources.first.product_name
      end
    end

  end
end
