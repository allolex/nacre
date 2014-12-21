require 'nacre/abstract_resource'
require 'nacre/concerns/searchable'
require 'date'

module Nacre

  class Order < AbstractResource

    extend Searchable
    extend Getable

    [
      :acknowledged,
      :allocation_status_code,
      :assignment,
      :contact_id,
      :cost_price_list_id,
      :created_by_id,
      :created_on,
      :currency,
      :customer_ref,
      :delivery,
      :id,
      :invoices,
      :null_custom_fields,
      :order_payment_status,
      :order_payment_status_id,
      :order_rows,
      :order_status,
      :order_status_id,
      :order_stock_status_id,
      :order_type_id,
      :order_type_code,
      :parent_order_id,
      :parties,
      :placed_on,
      :price_list_id,
      :price_mode_code,
      :reference,
      :shipping_status_code,
      :stock_status_code,
      :total_value,
      :warehouse_id
    ].each { |field| attribute field }

    def self.resource_class
      self
    end

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
