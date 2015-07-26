require "nacre/abstract_resource"
require "nacre/concerns/searchable"

module Nacre
  class NominalCode < AbstractResource

    extend Searchable
    extend Getable

    attribute :active
    attribute :bank
    attribute :chart_map_code
    attribute :code
    attribute :description
    attribute :discount
    attribute :editable
    attribute :expense
    attribute :id
    attribute :name
    attribute :reconcile
    attribute :tax_code
    attribute :type

    def self.resource_class
      self
    end

    def self.resource_name
      "nominal-code"
    end

    private

    def self.service_name
      "accounting"
    end

    def self.request_options
      ""
    end
  end
end
