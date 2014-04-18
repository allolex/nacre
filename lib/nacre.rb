require 'nacre/version'
require 'nacre/configuration'

require 'nacre/connection'
require 'nacre/response'
require 'nacre/authentication'

require 'nacre/search_results'

require 'nacre/order'
require 'nacre/order_collection'

require 'nacre/order/contact'
require 'nacre/order/currency'
require 'nacre/order/delivery_details'
require 'nacre/order/invoice'
require 'nacre/order/invoice_collection'
require 'nacre/order/party_details'
require 'nacre/order/status'
require 'nacre/order/value'

require 'nacre/product'
require 'nacre/product/identity'
require 'nacre/product/financial_details'
require 'nacre/product/sales_channel'
require 'nacre/product/sales_channel_collection'
require 'nacre/product/description'
require 'nacre/product/tax_code'
require 'nacre/product/stock_details'

module Nacre

  CAMEL_CASE_RE = /(?<=[a-z])[A-Z]/

  class << self
    attr_accessor :configuration, :link
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
