module Nacre
  class Authentication
    attr_reader :token

    def initialize(response_body)
      @token = response_body["response"]
    end

    def active?
      !self.token.nil?
    end
  end
end
