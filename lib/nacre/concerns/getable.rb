module Nacre::Getable

  def get(range)
    request_url = build_request_url(url, range, request_options)
    response = link.get(request_url)
    if response.success?
      from_json(response.body)
    else
      raise ArgumentError, "Request error: #{request_url}\n#{response.body}"
    end
  end

  private

  def url
    service_url + '/' + service_name
  end

  def request_options
    'includeOptional=customFields,nullCustomFields'
  end

  def build_request_url(url, query, options = nil)
    if options
      "#{url}/#{query.to_s}?#{options}"
    else
      "#{url}/#{query.to_s}"
    end
  end

  def range?(arg)
    /\d[,-]\d?/ === arg
  end
end
