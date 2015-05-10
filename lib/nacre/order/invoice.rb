require "date"

module Nacre
  class Order::Invoice < AbstractResource

    attribute :tax_date
    attribute :due_date
    attribute :invoice_reference

    def due_date=(iso_date)
      @due_date = DateTime.iso8601(iso_date)
    end

    def due_date
      @due_date.strftime(time_format)
    end

    def due_date_raw
      @due_date
    end

    def tax_date=(iso_date)
      @tax_date = DateTime.iso8601(iso_date)
    end

    def tax_date
      @tax_date.strftime(time_format)
    end

    def tax_date_raw
      @tax_date
    end

    private

    def time_format
      "%Y-%m-%dT%H:%M:%S.%LZ"
    end
  end
end
