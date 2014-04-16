require 'nacre/abstract_resource'

module Nacre

  class Order < AbstractResource

    attribute :acknowledged
    attribute :allocation_status_code
    attribute :contact_id
    attribute :cost_price_list_id
    attribute :created_by_id
    attribute :created_on
    attribute :customer_ref
    attribute :id
    attribute :invoices
    attribute :null_custom_fields
    attribute :order_payment_status
    attribute :order_payment_status_id
    attribute :order_status_id
    attribute :order_stock_status_id
    attribute :order_type_id
    attribute :parent_order_id
    attribute :price_list_id
    attribute :price_mode_code
    attribute :reference
    attribute :shipping_status_code
    attribute :stock_status_code
    attribute :warehouse_id

    def invoices=(invoice_params_list)
      @invoices = Order::InvoiceCollection.new(invoice_params_list)
    end

    def null_custom_fields=(list)
      @null_custom_fields = list unless list.nil? || list.empty?
    end
  end
end
