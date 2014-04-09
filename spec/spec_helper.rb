require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
end

require 'dotenv'  # First line of spec_helper
Dotenv.load       # Second line of spec_helper

require 'pry'
require 'rspec'
require 'awesome_print'
require 'webmock/rspec'

require 'nacre'
require 'coveralls'

Coveralls.wear!

Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each do
  |support_file| require support_file
end

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:each) do
    Nacre.configure do |c|
      c.user_id = ENV['NACRE_USER_ID']
      c.email = ENV['NACRE_EMAIL']
      c.password = ENV['NACRE_PASSWORD']
    end

    stub_request(:post, "https://ws-eu1.brightpearl.com/%s/authorise" % [ ENV['NACRE_USER_ID'] ]).
      to_return(:status => 200, :body => auth_response_success_body, :headers => {})
  end

end

def fixture_file_content(file_name)
  fixture_file(file_name).read.chomp
end

def fixture_file(file_name)
  File.open("spec/support/fixtures/#{file_name}")
end

include AuthenticationHelper
include NacreConfigHelper
