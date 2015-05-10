require "nacre/request_url"

module Nacre::Searchable
  def find(id_list = [])
    current_options = search_options_from_ids id_list
    request_url = Nacre::RequestUrl.new current_options
    response = link.get request_url.to_s
    Nacre::SearchResultsCollection.from_json(
      response.body,
      current_options
    )
  end

  def search_options_from_ids(id_list)
    id_value = [id_list].flatten.join(",")

    default_search_options.merge(
      fields: { resource_id => id_value }
    )
  end

  def default_search_options
    options = {}
    options[:options]    = default_get_options
    options[:pagination] = default_pagination_options
    options[:search_url] = search_url
    options
  end

  def default_get_options
    %w/customFields nullCustomFields/
  end

  def default_pagination_options
    {
      first_record: 1,
      window: 500
    }
  end

  private

  def resource_id
    "#{resource_name}_id".to_sym
  end

  def search_url
    "#{service_url}/#{resource_name}-search"
  end
end
