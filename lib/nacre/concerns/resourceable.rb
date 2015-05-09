module Nacre::Resourceable

  def resource_name
    format_resource_name(resource_class)
  end

  def service_name
    resource_name # Override when different from resource
  end

  def resource_class
    raise NotImplementedError, "Including object must implement .#{__method__}"
  end

  private

  def format_resource_name(name)
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
