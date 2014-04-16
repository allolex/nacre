require 'spec_helper'

describe Nacre::Order::Contact do
  let(:params) do
    {
      address_full_name: 'Billing',
      address_line1: '1, rue de Rivoli',
      address_line2: 'Centre-Ville',
      address_line3: 'Chez les riches',
      address_line4: 'Paris',
      company_name: 'Generic Distribution',
      contact_id: 322,
      country: 'France',
      country_id: 73,
      email: 'accounts@example.com',
      mobile_telephone: '0033699999999',
      postal_code: '75000',
      telephone: '0033199999999'
    }
  end

  subject { described_class.new(params) }

  it 'should have a full name' do
    expect(subject.address_full_name).to eq('Billing')
  end

  it 'should have first address line' do
    expect(subject.address_line1).to eq('1, rue de Rivoli')
  end

  it 'should have second address line' do
    expect(subject.address_line2).to eq('Centre-Ville')
  end

  it 'should have third address line' do
    expect(subject.address_line3).to eq('Chez les riches')
  end

  it 'should have fourth address line' do
    expect(subject.address_line4).to eq('Paris')
  end

  it 'should have a company name' do
    expect(subject.company_name).to eq('Generic Distribution')
  end

  it 'should have a contact ID' do
    expect(subject.contact_id).to eq(322)
  end

  it 'should have a country' do
    expect(subject.country).to eq('France')
  end

  it 'should have a country ID' do
    expect(subject.country_id).to eq(73)
  end

  it 'should have an email address' do
    expect(subject.email).to eq('accounts@example.com')
  end

  it 'should have a mobile phone number' do
    expect(subject.mobile_telephone).to eq('0033699999999')
  end

  it 'should have a postal code' do
    expect(subject.postal_code).to eq('75000')
  end

  it 'should have a telephone number' do
    expect(subject.telephone).to eq('0033199999999')
  end

  it_should_behave_like 'Parametrizable'
end
