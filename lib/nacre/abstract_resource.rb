require 'nacre/concerns/matchable'
require 'nacre/concerns/parametrizable'

module Nacre
  class AbstractResource

    include Matchable
    include Parametrizable

    def self.fields
      @fields ||= []
    end

    def self.attribute(name)
      self.fields << name
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
  end
end
