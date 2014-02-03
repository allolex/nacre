require 'dotenv'  # First line of spec_helper
Dotenv.load       # Second line of spec_helper

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
end

require 'pry'
require 'rspec'
require 'awesome_print'
require 'webmock/rspec'

require 'nacre'

Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each do
  |support_file| require support_file
end

RSpec.configure do |config|

  config.before(:each) do
    Nacre.configure do |c|
      c.email = ENV['NACRE_USER_ID']
      c.password = ENV['NACRE_PASSWORD']
    end
  end

end

include AuthenticationHelper
