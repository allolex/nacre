require "json"
require "faraday"
require "nacre/concerns/matchable"

module Nacre

  class NotAuthenticatedError < StandardError; end

  class Connection

    include Matchable

    attr_reader :link, :authentication

    attr_accessor :response, :errors

    def initialize(
        user_id: Nacre.configuration.user_id,
        email: Nacre.configuration.email,
        password: Nacre.configuration.password
      )
      self.errors = []
      initialize_link
      authenticate!
      set_persistent_link(self.link)
    end

    def success?
      self.response.success?
    end

    def reset_credentials
      @authentication = nil
    end

    def authenticate!
      reset_credentials
      api_response = @link.post(configuration.auth_url, auth_params)
      @response = Response.new(api_response)
      if self.response.success?
        @authentication = Authentication.new(self.response.body)
        configuration.authentication_token = @authentication.token
      end
      self.response
    end

    def authenticated?
      !self.authentication.nil? && self.authentication.active?
    end

    def get(url)
      self.link.headers["brightpearl-auth"] = self.authentication.token
      self.response = self.link.get(url)
      raise NotAuthenticatedError if authentication_failed?
      self.response
    end

    private

    def authentication_failed?
      response_string = self.response.body["response"]
      return false if blank?(response_string)
      /\ANot authenticated/ === response_string
    end

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
      @link.headers["Content-Type"] = "application/json"
      @link.headers["Accept"] = "json"
    end

    def configuration
      Nacre.configuration
    end

    def set_persistent_link(link)
      Nacre.link = self
    end
  end
end
