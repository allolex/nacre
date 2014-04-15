require 'json'
require 'faraday'
require 'pry'
require 'nacre/concerns/matchable'

module Nacre

  class NotAuthenticatedError < StandardError; end

  class Connection

    include Matchable

    attr_reader :response, :link, :authentication

    def initialize(args = {})
      initialize_link
      authenticate!
      set_persistent_link(self.link)
    end

    def success?
      self.response.success?
    end

    def authenticate!
      @authentication = nil
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
      self.link.headers['brightpearl-auth'] = self.authentication.token
      response = self.link.get(url)
      raise NotAuthenticatedError if authentication_failed?(response)
      response
    end

    private

    def authentication_failed?(response)
      unless blank?(response.body)
        response.body['response'].match(/\ANot authenticated/)
      end
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
      @link.headers['Content-Type'] = 'application/json'
      @link.headers['Accept'] = 'json'
    end

    def configuration
      Nacre.configuration
    end

    def set_persistent_link(link)
      Nacre.link = self
    end
  end
end
