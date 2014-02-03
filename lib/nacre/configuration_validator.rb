module Nacre::ConfigurationValidator
  def self.validate(config)
    !! (config.email =~ /\S+@\S+\.\S+/) &&
    !config.password.nil?
  end
end
