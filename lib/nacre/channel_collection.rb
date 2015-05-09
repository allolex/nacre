require 'nacre/abstract_resource_collection'

module Nacre
  class ChannelCollection < AbstractResourceCollection

    private

    def self.resource_class
      Channel
    end

    def self.request_options
      nil
    end

    def self.service_name
      'product'
    end
  end
end
