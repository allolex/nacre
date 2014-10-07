require 'spec_helper'

describe Nacre::Response do

  let(:api_response) { Faraday::Response.new }
  let(:response) { Nacre::Response.new(api_response) }

  context 'with a valid response' do
    before do
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return(auth_response_success_body)
      allow_any_instance_of(Faraday::Response).to receive(:success?).and_return(true)
    end

    it 'should have a body' do
      expect(response.body).to_not be_nil
    end

    it 'should be successful' do
      expect(response).to be_success
    end
  end

  context 'with a failure response' do
    before do
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return(auth_response_failure_body)
      allow_any_instance_of(Faraday::Response).to receive(:success?).and_return(false)
    end

    it 'should have a body' do
      expect(response.body).to_not be_nil
    end

    it 'should fail' do
      expect(response).to_not be_success
    end

    it 'should have errors' do
      expect(response.errors).to be_a(Array)
      expect(response.errors.first['message']).to match('Unable')
    end
  end
end
