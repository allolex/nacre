module Nacre
  class Authentication
    attr_reader :token

    def initialize(response_body)
      parsed_body = JSON.parse(response_body)
      @token = parsed_body['response']
    end

    def active?
      !self.token.nil?
    end
  end
end
