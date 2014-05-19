module Nacre
  class RequestUrl < AbstractResource

    include Inflectible

    attribute :options
    attribute :pagination
    attribute :fields
    attribute :search_url

    KEY_MAP = {
      first_record: 'firstResult',
      window: 'pageSize'
    }

    def post_initialize
      @pagination = @pagination || default_pagination
    end

    def fields
      @fields.map { |k,v| "#{camelize(k)}=#{v}" }
    end

    def pagination
      @pagination.map { |k,v| "#{KEY_MAP[k]}=#{v}" }
    end

    def pagination_params
      @pagination
    end

    def options
      ["includeOptional=#{@options.join(',')}"]
    end

    def arguments
      fields.sort + (pagination + options).sort
    end

    def to_s
      "#{search_url}?#{arguments.join('&')}"
    end

    private

    def default_pagination
      {
        first_record: 1,
        window: 500
      }
    end
  end
end
