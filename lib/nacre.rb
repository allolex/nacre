require "nacre/version"
require "nacre/configuration"

require "nacre/connection"
require "nacre/response"
require "nacre/authentication"

require "nacre/order"
require "nacre/order_collection"

module Nacre
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
