module Nacre::Getable

  def get(range)
    request_url = build_request_url(url,range,request_options)
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

  def build_request_url(url, query, options)
    "#{url}/#{query.to_s}?#{options}"
  end
end
