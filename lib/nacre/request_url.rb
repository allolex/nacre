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
  end
end
