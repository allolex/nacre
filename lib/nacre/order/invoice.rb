require 'date'

module Nacre
  class Order::Invoice < AbstractResource

    attribute :tax_date
    attribute :due_date
    attribute :invoice_reference

    def due_date=(iso_date)
      @due_date = DateTime.iso8601(iso_date)
    end

    def tax_date=(iso_date)
      @tax_date = DateTime.iso8601(iso_date)
    end

  end
end
