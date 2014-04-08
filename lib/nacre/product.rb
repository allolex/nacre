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

    def params
      params = {}
      FIELDS.each do |key|
        params[key] = if self.send(key).respond_to?(:params)
                        self.send(key).params
                      else
                        self.send(key)
                      end
      end
      params
    end

    def identity=(params)
      @identity = Nacre::Product::Identity.new(params)
    end

    def sales_channels=(channels_list)
      @sales_channels = Nacre::Product::SalesChannelCollection.new(channels_list)
    end

    private

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first
      {
        product_id: resource['id'].to_i,
        identity: resource['identity'],
        sales_channels: resource['salesChannels'],
        brand_id: resource['brandId']
      }
    end
  end
end
