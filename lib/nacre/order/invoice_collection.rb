require 'nacre/concerns/collectible'

module Nacre
  class Order::InvoiceCollection
    include Collectible

    def self.resource_class
      Nacre::Order::Invoice
    end
  end
end
