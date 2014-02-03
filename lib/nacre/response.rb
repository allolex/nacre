module Nacre
  class Response

    attr_reader :body, :api_response

    def initialize(api_response)
      @api_response = api_response
      @body = JSON.parse(self.api_response.body)
    end

    def success?
      @api_response.success?
    end

  end
end
