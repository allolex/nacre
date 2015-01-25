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
      'channel'
    end

    def self.service_url
      configuration.resource_url + '/' + 'product-service'
    end

    def self.url
      service_url + '/' + service_name
    end
  end
end
