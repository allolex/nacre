module Nacre
  class Product::Description

    include Matchable
    include Parametrizable

    FIELDS = [
      :language_code,
      :text,
      :format
    ]

    FIELDS.each do |field|
      attr_accessor field
    end

    def initialize(options = {})
      fill_attributes(options)
    end

    private

    def fill_attributes(options)
      FIELDS.each do |attrib|
        self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
      end
    end
  end
end
