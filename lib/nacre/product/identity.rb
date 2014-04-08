require 'nacre/concerns/matchable'
require 'nacre/concerns/parametrizable'

class Nacre::Product::Identity

  FIELDS = [
    :sku,
    :isbn,
    :ean,
    :upc,
    :barcode
  ]

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

end
