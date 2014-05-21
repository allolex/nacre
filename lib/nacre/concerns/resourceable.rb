module Nacre::Resourceable

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
