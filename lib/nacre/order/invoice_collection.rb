require 'nacre/concerns/collectible'

module Nacre
  class Order::InvoiceCollection
    include Collectible
    include Enumerable

    def self.resource_class
      Nacre::Order::Invoice
    end
  end
end
