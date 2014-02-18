require 'spec_helper'

describe Nacre::Connection do
  let(:args) do
    {
      user_id: nacre_user_id,
      email: nacre_email,
      password: nacre_password
    }
  end

  let(:connection) { Nacre::Connection.new(args) }

  before do
    stub_request(:post, "https://ws-eu1.brightpearl.com/%s/authorise" % [ ENV['NACRE_USER_ID'] ]).
      to_return(:status => 200, :body => auth_response_success_body, :headers => {})
  end

  describe '#authentication_token' do

    it 'should be set' do
      expect(connection.authentication.token).to_not be_nil
    end
  end

  describe '#link' do

    it 'should have a HTTP client link' do
      expect(connection.link).to respond_to(:get)
      expect(connection.link).to respond_to(:post)
    end

    it 'should have the correct headers' do
      expect(connection.link.headers['Content-Type']).to eq('application/json')
      expect(connection.link.headers['Accept']).to eq('json')
    end
  end

  describe '.authenticate!' do

    context 'with good credentials' do
      it 'should return a successful response' do
        expect(connection.authenticate!).to be_success
      end

      it 'should should be authenticated' do
        expect(connection).to be_authenticated
      end
    end

    context 'with bad credentials' do
      before do
        stub_request(:post, "https://ws-eu1.brightpearl.com/%s/authorise" % [ ENV['NACRE_USER_ID'] ]).
          to_return(:status => 400, :body => auth_response_failure_body, :headers => {})
      end

      let(:args) do
        {
          user_id: 'xxxxxxxxx',
          email: 'this@example.com',
          password: 'password'
        }
      end

      it 'should return a failure response' do
        expect(connection.authenticate!).to_not be_success
      end

      it 'should should not be authenticated' do
        expect(connection).to_not be_authenticated
      end
    end
  end

  describe '#get' do

    let(:url) { 'http://example.com/some_path' }

    it 'should send a GET request to the given URL' do
      Faraday::Connection.any_instance.should_receive(:get).with(url)
      Nacre::Connection.new.get(url)
    end
  end
end
