require 'nacre/concerns/matchable'

class Nacre::Product::Identity

  FIELDS = [
    :sku,
    :isbn,
    :ean,
    :upc,
    :barcode
  ]

  include Matchable

  FIELDS.each do |field|
    attr_accessor field
  end

  def initialize(options = {})
    FIELDS.each do |attrib|
      self.send("#{attrib.to_s}=",options[attrib]) unless blank?(options[attrib])
    end
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
end
