module Nacre
  class RequestUrl < AbstractResource

    include Inflectible

    attribute :options
    attribute :pagination
    attribute :ids
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
      return nil if blank?(@fields)
      @fields.map { |k,v| "#{camelize(k)}=#{v}" }
    end

    def ids
      if @ids.respond_to?(:each)
        @ids.join(',')
      else
        @ids
      end
    end

    def pagination
      if blank?(@ids)
        @pagination.map { |k,v| "#{KEY_MAP[k]}=#{v}" }
      else
        ''
      end
    end

    def pagination_params
      @pagination
    end

    def options
      if @options
        ["includeOptional=#{@options.join(',')}"]
      else
        []
      end
    end

    def arguments
      if @ids.nil?
        fields.sort + (pagination + options).sort
      else
        options.sort
      end
    end

    def to_s
      if @ids.nil?
        "#{search_url}?#{arguments.join('&')}"
      else
        "#{search_url}/#{ids}?#{arguments.join('&')}"
      end
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
