require 'nacre/abstract_resource'
require 'date'

module Nacre

  class Order < AbstractResource

    attribute :acknowledged
    attribute :allocation_status_code
    attribute :assignment
    attribute :contact_id
    attribute :cost_price_list_id
    attribute :created_by_id
    attribute :created_on
    attribute :currency
    attribute :customer_ref
    attribute :delivery
    attribute :id
    attribute :invoices
    attribute :null_custom_fields
    attribute :order_payment_status
    attribute :order_payment_status_id
    attribute :order_rows
    attribute :order_status
    attribute :order_status_id
    attribute :order_stock_status_id
    attribute :order_type_id
    attribute :parent_order_id
    attribute :parties
    attribute :placed_on
    attribute :price_list_id
    attribute :price_mode_code
    attribute :reference
    attribute :shipping_status_code
    attribute :stock_status_code
    attribute :total_value
    attribute :warehouse_id

    def invoices=(invoice_params_list)
      @invoices = Order::InvoiceCollection.new(invoice_params_list)
    end

    def null_custom_fields=(list)
      @null_custom_fields = list unless list.nil? || list.empty?
    end

    def placed_on=(iso_date)
      @placed_on = DateTime.iso8601(iso_date)
    end

    def currency=(params)
      @currency = Order::Currency.new(params)
    end

    def order_status=(params)
      @order_status = Order::Status.new(params)
    end

    def total_value=(params)
      @total_value = Order::Value.new(params)
    end

    def delivery=(params)
      @delivery = Order::DeliveryDetails.new(params)
    end

    def parties=(params)
      @parties = Order::PartyDetails.new(params)
    end

    def assignment=(params)
      @assignment = Order::AssignmentCollection.new(params)
    end

    def order_rows=(params)
      @order_rows = Order::RowCollection.new(params)
    end
  end
end
