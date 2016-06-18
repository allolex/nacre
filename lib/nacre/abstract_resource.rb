require "uri"
require "json"
require "nacre/concerns/matchable"
require "nacre/concerns/parametrizable"
require "nacre/concerns/inflectible"
require "nacre/concerns/resourceable"
require "nacre/concerns/getable"

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
      prevent_empty_resource! attributes_hash

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

    def prevent_empty_resource!(attributes_hash)
      if attributes_hash.nil?
        raise(
          Nacre::EmptyResourceError,
          "#{self.class} initialized with empty attributes."
        )
      end
    end

    def self.list_extracted_errors(json)
      parsed_body = JSON.parse(json, symbolize_names: true)
      parsed_body[:errors]
    end

    def self.params_from_json(json)
      resource = JSON.parse(json)["response"].first
      format_hash_keys(resource)
    end

    def true?(value)
      value == true || value == "true"
    end
  end
end
