require 'json'
require 'faraday'

module Nacre
  class Connection

    attr_reader :response, :link, :authentication

    def initialize(args = {})
      initialize_link
      authenticate!
    end

    def success?
      self.response.success?
    end

    def authenticate!
      @authentication = nil
      @response = @link.post(configuration.auth_url, auth_params)
      if @response.success?
        @authentication = Authentication.new(self.response.body)
      end
      Response.new(@response)
    end

    def authenticated?
      !self.authentication.nil? && self.authentication.active?
    end

    private

    def auth_params
      {
        "apiAccountCredentials" => {
          "emailAddress" => configuration.email,
          "password" => configuration.password
        }
      }.to_json
    end

    def initialize_link
      @link = Faraday.new
      set_link_headers
    end

    def set_link_headers
      @link.headers['Content-Type'] = 'application/json'
      @link.headers['Accept'] = 'json'
    end

    def configuration
      Nacre.configuration
    end
  end
end
