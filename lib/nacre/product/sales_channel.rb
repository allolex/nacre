require 'nacre/concerns/matchable'

module Nacre
  class Product::SalesChannel

    include Matchable
    include Parametrizable

    FIELDS = [
      :sales_channel_name,
      :product_name,
      :product_condition,
      :categories,
      :description,
      :short_description
    ]

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(options = {})
      fill_attributes(options)
    end

    def description=(options = {})
      @description = Product::Description.new(options)
    end

    def short_description=(options = {})
      @short_description = Product::Description.new(options)
    end

    private

    def fill_attributes(options)
      FIELDS.each do |attrib|
        self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
      end
    end
  end
end
