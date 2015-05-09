require 'nacre/abstract_resource'
require 'nacre/concerns/searchable'

module Nacre
  class Channel < AbstractResource

    extend Searchable
    extend Getable

    attribute :id
    attribute :name
    attribute :channel_type_id
    attribute :channel_brand_id
    attribute :default_warehouse_id
    attribute :contact_group_id
    attribute :default_price_list_id
    attribute :warehouse_ids
    attribute :integration_detail

    def self.resource_class
      self
    end

    def warehouse_ids=(hash)
      @warehouse_ids = hash unless hash.nil? || hash.empty?
    end

    private

    def self.service_name
      'product'
    end

    def self.request_options
      ''
    end
  end
end
