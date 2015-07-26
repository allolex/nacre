require "nacre/abstract_resource_collection"

module Nacre
  class NominalCodeCollection < AbstractResourceCollection

    private

    def self.resource_class
      NominalCode
    end

    def self.request_options
      nil
    end

    def self.service_name
      "accounting"
    end

    def self.resource_name
      "nominal-code"
    end
  end
end
