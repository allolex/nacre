require 'uri'
require 'json'

class Nacre::Order

  attr_reader :id, :parent_order_id

  def initialize(options)
    @id = options['id'].to_s
    @parent_order_id = options['parentOrderId'].to_s
  end

  def self.find(id_list = [])
    Nacre::Connection.get(query_uri)
  end

  private

  def self.build_uri(query, options)
    "#{search_url}?#{escape_query(query)}#{options}"
  end

  def self.escape_query(query)
    if query.nil?
      ''
    else
      URI.escape(query + '&')
    end
  end

  def self.service_url
    '/order-service'
  end

  def self.url
    service_url + '/order'
  end

  def self.search_url
    service_url + '/order-search'
  end
end
