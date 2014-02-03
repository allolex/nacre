require "nacre/version"
require "nacre/configuration"

module Nacre
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
