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

    def self.resource_name
      'channel'
    end

    def self.service_url
      configuration.resource_url + '/' + 'product-service'
    end

    def self.url
      service_url + '/' + resource_name
    end
  end
end
