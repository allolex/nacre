module Nacre
  class Product::StockDetails

    FIELDS = [ :stock_tracked ]

    include Matchable
    include Parametrizable

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(options = {})
      FIELDS.each do |attrib|
        self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
      end
    end

    def stock_tracked=(value)
      @stock_tracked = value.to_s == 'true' ? true : false
    end

  end
end
