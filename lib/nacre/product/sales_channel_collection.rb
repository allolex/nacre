require "nacre/concerns/collectible"

module Nacre
  class Product::SalesChannelCollection
    include Collectible
    extend Inflectible

    def self.resource_class
      Nacre::Product::SalesChannel
    end

    def product_name
      name_sources = members.select do |member|
        member.sales_channel_name == "Brightpearl"
      end

      if name_sources.empty?
        nil
      else
        name_sources.first.product_name
      end
    end
  end
end
