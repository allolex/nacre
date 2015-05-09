require "nacre/abstract_resource"
require "nacre/concerns/searchable"
require "date"

module Nacre
  class Journal < AbstractResource
    extend Searchable
    extend Getable

    [
      :contact_id,
      :created_by_contact_id,
      :created_by_contact_id,
      :created_on,
      :created_on,
      :credits,
      :debits,
      :description,
      :due_date,
      :id,
      :journal_type_code,
      :tax_date,
      :tax_reconciliation
    ].each { |field| attribute field }

    def self.resource_class
      Journal
    end

    private

    def self.service_name
      "accounting"
    end

    def self.request_options
      nil
    end

    def self.params_from_json(json)
      resource = JSON.parse(json)["response"]["journals"].first
      format_hash_keys(resource)
    end
  end
end
