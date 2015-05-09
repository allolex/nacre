require "nacre/abstract_resource"

module Nacre
  class Product::Identity < AbstractResource

    attribute :sku
    attribute :isbn
    attribute :ean
    attribute :upc
    attribute :barcode

  end
end
