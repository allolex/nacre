module Nacre
  class Journal::Entry < AbstractResource
    attribute :nominal_code
    attribute :change
    attribute :assignment
    attribute :order_id
    attribute :tax_code

    def value
      BigDecimal.new(change[:value])
    end

    def channel_id
      assignment[:channel_id]
    end
  end
end
