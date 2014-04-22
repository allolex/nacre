module Nacre::Searchable

  def find(id_list = [])
    id_list = [id_list] unless id_list.kind_of?(Array)
    request_url = build_search_url(
      search_url,
      "#{service_name}Id=#{id_list.join(',')}"
    )
    response = link.get(request_url)
    Nacre::SearchResults.from_json(response.body)
  end

  private

  def search_url
    service_url + '/' + service_name + '-search'
  end

end
