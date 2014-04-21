module Nacre
  class Order::Row::CompositionDetails < AbstractResource

    attribute :bundle_child
    attribute :bundle_parent
    attribute :parent_order_row_id

    def bundle_child=(value)
      @bundle_child = false
      @bundle_child = true if true?(value)
    end

    def bundle_parent=(value)
      @bundle_parent = false
      @bundle_parent = true if true?(value)
    end
  end
end
