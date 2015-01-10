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

    VALID_RANGE_RE = /\A(?:\d+(?:(?:,\d+)+|(?:-\d+))?)?\z/

    def post_initialize
      @pagination = @pagination || default_pagination
    end

    def fields
      return [] if blank?(@fields)
      @fields.map { |k,v| "#{camelize(k)}=#{v}" }
    end

    def ids
      if @ids.respond_to?(:each)
        @ids.join(',')
      else
        @ids
      end
    end

    def ids=(range)
      validate_ids(range)
      @ids = range
    end

    def pagination
      return '' if !blank?(ids)
      @pagination.map { |k,v| "#{KEY_MAP[k]}=#{v}" }
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
      if blank?(@ids)
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

    def validate_ids(value)
      if value.respond_to?(:each)
        validate_range_items(value)
      else
        validate_range(value, 'Invalid range')
      end
    end

    def validate_range_items(range_list)
      range_list.each do |item|
        validate_range(item, 'Invalid range item')
      end
    end

    def validate_range(range,error_message)
      unless VALID_RANGE_RE === range.to_s
        raise ArgumentError, "#{error_message}: '#{range}'"
      end
    end
  end
end
