module Nacre::Resourceable

  def service_name
    format_service_name(resource_class)
  end

  def resource_class
    raise NotImplementedError, "Including object must implement .#{__method__}"
  end

  private

  def format_service_name(name)
    resource_class.to_s.gsub(/\ANacre::/, '').downcase
  end

  def service_url
    configuration.resource_url + '/' + service_name + '-service'
  end

  def configuration
    Nacre.configuration
  end

  def link
    Nacre.link
  end
end
