module Nacre
  class ProductPrice < AbstractResource

    attribute :product_id
    attribute :price_lists

    def price_lists=(params)
      @price_lists = PriceListCollection.new(params)
    end

    private

    def self.resource_options
      ''
    end

    def self.service_name
      'price-list'
    end

    def self.service_url
      configuration.resource_url + '/' + 'product-service'
    end

    def self.url
      service_url + '/' + service_name
    end

  end
end
