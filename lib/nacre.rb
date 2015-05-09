require 'nacre/authentication'
require 'nacre/column_property'
require 'nacre/configuration'
require 'nacre/connection'

require 'nacre/journal'
require 'nacre/order'
require 'nacre/product'

require 'nacre/journal_collection'

require 'nacre/order/assignment'
require 'nacre/order/assignment_collection'
require 'nacre/order/contact'
require 'nacre/order/currency'
require 'nacre/order/delivery_details'
require 'nacre/order/invoice'
require 'nacre/order/invoice_collection'
require 'nacre/order/party_details'
require 'nacre/order/row'
require 'nacre/order/row/amount'
require 'nacre/order/row/composition_details'
require 'nacre/order/row/product_options'
require 'nacre/order/row/quantity'
require 'nacre/order/row/value'
require 'nacre/order/row_collection'
require 'nacre/order/status'
require 'nacre/order/value'
require 'nacre/order_collection'

require 'nacre/price_list'
require 'nacre/price_list_collection'

require 'nacre/product/description'
require 'nacre/product/financial_details'
require 'nacre/product/identity'
require 'nacre/product/sales_channel'
require 'nacre/product/sales_channel_collection'
require 'nacre/product/stock_details'
require 'nacre/product/tax_code'
require 'nacre/product_collection'
require 'nacre/product_price'

require 'nacre/channel'
require 'nacre/channel_collection'

require 'nacre/request_url'
require 'nacre/response'
require 'nacre/search_results'
require 'nacre/search_results_collection'
require 'nacre/version'

module Nacre

  class << self
    attr_accessor :configuration, :link
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
