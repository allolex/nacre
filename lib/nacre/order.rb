require 'nacre/abstract_resource'

module Nacre

  class Order < AbstractResource

    attribute :id
    attribute :parent_order_id
    attribute :order_type_id
    attribute :contact_id
    attribute :order_status_id
    attribute :order_stock_status_id
    attribute :created_on
    attribute :created_by_id
    attribute :customer_ref
    attribute :invoices
    attribute :order_payment_status_id

    def invoices=(invoice_params_list)
      @invoices = Order::InvoiceCollection.new(invoice_params_list)
    end
  end
end
