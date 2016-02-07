require "nacre/configuration_validator"

module Nacre
  class Configuration

    attr_accessor :base_url,
                  :email,
                  :password,
                  :distribution_center,
                  :user_id,
                  :authentication_token,
                  :api_version,
                  :value_precision

    def initialize(args = {})
      @email = default_email
      @password = default_password
      @distribution_center = default_distribution_center
      @api_version = default_api_version
      @user_id = default_user_id
      @api_version = default_api_version
      @value_precision = default_value_precision
      args.each_pair do |option, value|
        self.send("#{option}=", value)
      end
    end

    def valid?
      ConfigurationValidator.validate(self)
    end

    def base_url
      url_template % [distribution_center]
    end

    def auth_url
      "#{base_url}/%s/authorise" % [user_id]
    end

    def resource_url
      "#{base_url}/%s/%s" % [api_version, user_id]
    end

    private

    def default_email
      ENV["NACRE_EMAIL"]
    end

    def default_password
      ENV["NACRE_PASSWORD"]
    end

    def default_distribution_center
      ENV["NACRE_DISTRIBUTION_CENTER"] || "eu1"
    end

    def default_api_version
      "public-api"
    end

    def default_user_id
      ENV["NACRE_USER_ID"]
    end

    def default_value_precision
      ENV["NACRE_VALUE_PRECISION"] || "6"
    end

    def url_template
      "https://ws-%s.brightpearl.com"
    end
  end
end
