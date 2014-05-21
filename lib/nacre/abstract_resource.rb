require 'uri'
require 'json'
require 'nacre/concerns/matchable'
require 'nacre/concerns/parametrizable'
require 'nacre/concerns/inflectible'
require 'nacre/concerns/resourceable'
require 'nacre/concerns/getable'

module Nacre
  class AbstractResource

    extend Resourceable
    extend Inflectible

    include Matchable
    include Parametrizable

    def self.fields
      @fields ||= []
    end

    def self.attribute(name)
      fields << name
      attr_accessor name
    end

    def initialize(options = {})
      self.attributes = options
      post_initialize
      self
    end

    def attributes=(attributes_hash)
      self.class.fields.each do |field|
        if attributes_hash.has_key?(field.to_sym)
          public_send("#{field}=", attributes_hash[field.to_sym])
        end
      end
    end

    def self.from_json(json)
      if /response/ === json
        params = params_from_json(json)
        new(params)
      else
        link.errors = (list_extracted_errors(json) + link.errors).flatten
        nil
      end
    end

    def self.errors
      link.errors
    end

    private

    def post_initialize; end

    def self.list_extracted_errors(json)
      parsed_body = JSON.parse(json, symbolize_names: true)
      parsed_body[:errors]
    end

    def self.service_name
      format_service_name(name)
    end

    def self.format_service_name(name)
      name.gsub(/\ANacre::/, '').downcase
    end

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first
      format_hash_keys(resource)
    end

    def true?(value)
      value == true || value == 'true'
    end
  end
end
