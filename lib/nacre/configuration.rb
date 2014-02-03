require 'nacre/configuration_validator'

module Nacre
  class Configuration
    attr_accessor :base_url, :auth_url, :email, :password

    def initialize(args = {})
      @email = default_email
      @password = default_password
      args.each_pair do |option, value|
        self.send("#{option}=", value)
      end
    end

    def valid?
      ConfigurationValidator.validate(self)
    end

    private

    def default_email
      ENV['NACRE_EMAIL']
    end

    def default_password
      ENV['NACRE_PASSWORD']
    end
  end
end
