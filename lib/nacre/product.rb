module Nacre
  class Product

    include Matchable

    def self.fields
      @fields ||= []
    end

    def self.attribute(name)
      self.fields << name
      attr_accessor name
    end

    attribute :product_id
    attribute :brand_id
    attribute :product_type_id
    attribute :identity
    attribute :product_group_id
    attribute :stock
    attribute :financial_details
    attribute :sales_channels
    attribute :composition
    attribute :variations

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

    def params
      params = {}
      self.class.fields.each do |key|
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

    def financial_details=(params)
      @financial_details = Nacre::Product::FinancialDetails.new(params)
    end

    def stock=(params)
      @stock = Nacre::Product::StockDetails.new(params)
    end

    private

    def self.params_from_json(json)
      resource = JSON.parse(json)['response'].first
      {
        product_id: resource['id'].to_i,
        identity: resource['identity'],
        sales_channels: resource['salesChannels'],
        financial_details: resource['financialDetails'],
        stock: resource['stock'],
        brand_id: resource['brandId']
      }
    end
  end
end
