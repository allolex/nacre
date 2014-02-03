require 'spec_helper'

module AuthenticationHelper
  def auth_response_success_body
    fixture_file_content('auth_success_body.json')
  end

  def auth_response_failure_body
    fixture_file_content('auth_failure_body.json')
  end
end
