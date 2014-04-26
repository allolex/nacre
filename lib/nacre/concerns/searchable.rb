require 'nacre/request_url'

module Nacre::Searchable

  def find(id_list = [])
    id_value = [id_list].flatten.join(',')

    request_url = Nacre::RequestUrl.new(
      default_params.merge(
        search_url: search_url,
        fields: { resource_id => id_value }
      )
    )
    response = link.get(request_url.to_s)
    Nacre::SearchResults.from_json(response.body)
  end

  private

  def resource_id
    "#{service_name}_id".to_sym
  end

  def search_url
    service_url + '/' + service_name + '-search'
  end

  def default_params
    {
      pagination: {
        first_record: 1,
        window: 100
      },
      options: [
        'customFields',
        'nullCustomFields'
      ]
    }
  end
end
