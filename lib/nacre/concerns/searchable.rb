require "nacre/request_url"

module Nacre::Searchable

  def find(id_list = [])
    id_value = [id_list].flatten.join(",")

    current_search_options =  default_search_options.merge(
                                search_url: search_url,
                                fields: { resource_id => id_value }
                              )
    request_url = Nacre::RequestUrl.new(current_search_options)
    response = link.get(request_url.to_s)
    Nacre::SearchResultsCollection.from_json(response.body, current_search_options)
  end

  def default_search_options
    options = default_get_options
    options[:pagination] =  {
                              first_record: 1,
                              window: 500
                            }
    options
  end

  def default_get_options
    {
      options: [
        "customFields",
        "nullCustomFields"
      ]
    }

  end

  private

  def resource_id
    "#{resource_name}_id".to_sym
  end

  def search_url
    service_url + "/" + resource_name + "-search"
  end
end
