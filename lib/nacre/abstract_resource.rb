require 'uri'
require 'json'
require 'nacre/concerns/matchable'
require 'nacre/concerns/parametrizable'
require 'nacre/concerns/inflectible'

module Nacre
  class AbstractResource

    include Matchable
    include Parametrizable
    extend Inflectible

    def self.fields
      @fields ||= []
    end

    def self.attribute(name)
      fields << name
      attr_accessor name
    end

    def initialize(options = {})
      self.attributes = options
    end

    def attributes=(attributes_hash)
      self.class.fields.each do |field|
        if attributes_hash.has_key?(field.to_sym)
          public_send("#{field}=", attributes_hash[field.to_sym])
        end
      end
    end

    def self.from_json(json)
      params = params_from_json(json)
      new(params)
    end

    def self.get(range)
      request_url = build_request_url(url,range,resource_options)
      response = link.get(request_url)
      from_json(response.body)
    end

    private

    def self.service_name
      format_service_name(name)
    end

    def self.format_service_name(name)
      name.gsub(/\ANacre::/, '').downcase
    end

    def self.build_request_url(url, query, options)
      "#{url}/#{query.to_s}?#{options}"
    end

    def self.build_search_url(url, query)
      "#{url}?#{query.to_s}"
    end

    def self.resource_options
      'includeOptional=customFields,nullCustomFields'
    end

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first
      format_hash_keys(resource)
    end

    def self.format_hash_keys(value)
      case value
      when Hash
        Hash[value.map { |k, v| [fix_key(k), format_hash_keys(v)] }]
      when Array
        value.map { |v| format_hash_keys(v) }
      else
        value
      end
    end

    def self.fix_key(key)
      if camel_case?(key)
        snake_case(key).to_sym
      else
        key.downcase.to_sym
      end
    end

    def self.camel_case?(key)
      Nacre::CAMEL_CASE_RE === key
    end

    def self.service_url
      configuration.resource_url + '/' + service_name + '-service'
    end

    def self.url
      service_url + '/' + service_name
    end

    def self.link
      Nacre.link
    end

    def self.configuration
      Nacre.configuration
    end

    def true?(value)
      value == true || value == 'true'
    end
  end
end
