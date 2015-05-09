require 'nacre/abstract_resource_collection'

module Nacre
  class JournalCollection < AbstractResourceCollection

    private

    def self.extract_resources(json)
      JSON.parse(json)['response']['journals']
    end

    def self.resource_class
      Journal
    end

    def self.request_options
      nil
    end

    def self.service_name
      'accounting'
    end
  end
end
