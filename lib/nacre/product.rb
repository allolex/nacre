module Nacre
  class Product

    include Matchable

    FIELDS = [
      :product_id,
      :brand_id,
      :product_type_id,
      :identity,
      :product_group_id,
      :stock,
      :financial_details,
      :sales_channels,
      :composition,
      :variations
    ]

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(options = {})
      FIELDS.each do |attrib|
        self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
      end
    end

    def self.from_json(json)
      params = params_from_json(json)
      new(params)
    end

    private

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first
      {
        product_id: resource['id'].to_i,
      }
    end
  end
end
