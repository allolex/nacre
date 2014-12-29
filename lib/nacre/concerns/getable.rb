module Nacre::Getable

  def get(range)
    if range?(range)
      request_url = build_request_url(url, range, request_options)
    else
      request_url = build_request_url(url, range)
    end
    response = link.get(request_url)
    from_json(response.body)
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
    /\d-\d/ === arg && /\d,\d/ === arg
  end
end
