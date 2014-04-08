require "nacre/version"
require "nacre/configuration"

require "nacre/connection"
require "nacre/response"
require "nacre/authentication"

require "nacre/order"
require "nacre/order_collection"
require "nacre/order_search_results"

require "nacre/product"
require "nacre/product/identity"
require 'nacre/product/sales_channel'
require 'nacre/product/sales_channel_collection'
require 'nacre/product/description'

module Nacre
  class << self
    attr_accessor :configuration, :link
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
