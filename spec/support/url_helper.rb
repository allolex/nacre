require 'spec_helper'

module UrlHelper

  def default_search_options(extra_options = [])
    options = %w/
      firstResult=1
      includeOptional=customFields,nullCustomFields
      pageSize=500
      /
    (options + extra_options).sort.join('&')
  end

  def default_get_options(extra_options = [])
    options = %w/
      includeOptional=customFields,nullCustomFields
      /
    (options + extra_options).sort.join('&')
  end

  def base_url
    'https://ws-eu1.brightpearl.com/%s/%s' %
      [Nacre.configuration.api_version, Nacre.configuration.user_id]
  end

  def auth_url
    'https://ws-eu1.brightpearl.com/%s/authorise' %
      [Nacre.configuration.user_id]
  end

  def resource_service_url(resource)
    "#{base_url}/#{resource}-service/#{resource}"
  end

  def order_service_url
    resource_service_url('order')
  end

  def product_service_url
    resource_service_url('product')
  end

  def price_list_service_url
    "#{base_url}/product-service/price-list"
  end

  def channel_service_url
    "#{base_url}/product-service/channel"
  end

  def resource_search_url(resource)
    "#{base_url}/#{resource}-service/#{resource}-search"
  end

  def order_search_url
    resource_search_url('order')
  end

  def product_search_url
    resource_search_url('product')
  end
end
