require 'spec_helper'

describe Nacre::Configuration do


  let(:config) { Nacre::Configuration.new(args) }

  context 'defaults' do
    let(:args) { {} }

    it 'should use defaults from the environment' do
      expect(config.user_id).to eql(ENV['NACRE_USER_ID'])
      expect(config.email).to eql(ENV['NACRE_EMAIL'])
      expect(config.password).to eql(ENV['NACRE_PASSWORD'])
      expect(config.base_url).to eql('https://ws-eu1.brightpearl.com')
    end
  end

  context 'with valid arguments' do
    let(:args) do
      {
        email: 'test@example.com',
        password: 'password',
        auth_url: 'https://auth.example.com/auth',
        auth_url: 'https://api.example.com/'
      }
    end

    it 'should be valid' do
      expect(config).to be_valid
    end
  end

  context 'with invalid arguments' do
    let(:args) do
      {
        email: '',
        auth_url: ''
      }
    end

    it 'should not be valid' do
      expect(config).to_not be_valid
    end
  end
end
