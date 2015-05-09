module Nacre
  class Response

    attr_reader :body, :api_response, :errors

    def initialize(api_response)
      @api_response = api_response
      @body = JSON.parse(api_response.body)
      @errors = @body["errors"] || []
    end

    def success?
      @api_response.success?
    end

  end
end
