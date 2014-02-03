require 'spec_helper'

describe Nacre::Authentication do

  context 'when authentication is successful' do
    let(:authentication) { Nacre::Authentication.new(auth_response_success_body) }

    let(:token_string) do
      JSON.parse(fixture_file_content('auth_success_body.json'))['response']
    end

    it 'should have a token' do
      expect(authentication.token).to eq(token_string)
    end

    it 'should be active' do
      expect(authentication).to be_active
    end
  end

  context 'when authentication is successful' do
    let(:authentication) { Nacre::Authentication.new(auth_response_failure_body) }

    let(:token_string) do
      JSON.parse(fixture_file_content('auth_failure_body.json'))['response']
    end

    it 'should have a token' do
      expect(authentication.token).to eq(token_string)
    end

    it 'should be inactive' do
      expect(authentication).to_not be_active
    end
  end

end
