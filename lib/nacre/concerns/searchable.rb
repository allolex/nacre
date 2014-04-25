module Nacre::Searchable

  def find(id_list = [])
    id_list = [id_list] unless id_list.kind_of?(Array)
    request_url = build_search_url(
      search_url,
      "#{service_name}Id=#{id_list.join(',')}",
      search_options
    )
    response = link.get(request_url)
    Nacre::SearchResults.from_json(response.body)
  end

  private

  def build_search_url(url, query, options)
    "#{url}?#{query.to_s}&#{options}"
  end

  def search_url
    service_url + '/' + service_name + '-search'
  end

  def default_pagination
    %w/pageSize=100 firstResult=1/
  end

  def search_options
    (
      default_pagination +
      %w/includeOptional=customFields,nullCustomFields/
    ).sort.join('&')
  end
end
