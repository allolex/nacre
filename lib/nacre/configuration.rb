require 'nacre/configuration_validator'

module Nacre
  class Configuration

    attr_accessor :base_url,
                  :auth_url,
                  :email,
                  :password,
                  :distribution_center,
                  :user_id,
                  :authentication_token

    def initialize(args = {})
      @email = default_email
      @password = default_password
      @distribution_center = default_distribution_center
      @api_version = default_api_version
      @user_id = default_user_id
      @base_url = default_base_url
      @auth_url = default_auth_url
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

    def default_distribution_center
      ENV['NACRE_DISTRIBUTION_CENTER'] || 'eu1'
    end

    def default_api_version
      ENV['NACRE_API_VERSION'] || '2.0.0'
    end

    def default_user_id
      ENV['NACRE_USER_ID']
    end

    def url_template
      "https://ws-%s.brightpearl.com"
    end

    def default_base_url
      url_template % [distribution_center]
    end

    def default_auth_url
      "#{default_base_url}/%s/authorise" % [user_id]
    end
  end
end
