require 'spec_helper'

describe Nacre::Order::PartyDetails do
  let(:params) do
    {
      delivery: {
        country: 'France',
        telephone: '0033199999999',
        mobile_telephone: '',
        address_line3: 'Paris',
        company_name: 'Generic Distribution',
        country_id: 73,
        address_line4: 'Paris',
        email: 'distro@example.com',
        address_line2: '',
        address_full_name: 'Delivery',
        address_line1: '1, rue de Rivoli',
        postal_code: '75000'
      },
      customer: {
        country: 'France',
        telephone: '0033199999999',
        mobile_telephone: '',
        contact_id: 322,
        address_line3: 'Paris',
        company_name: 'Generic Distribution',
        country_id: 73,
        address_line4: 'Paris',
        email: 'accounts@example.com',
        address_line2: '',
        address_full_name: 'Customer',
        address_line1: '1, rue de Rivoli',
        postal_code: '75000'
      },
      billing: {
        country: 'France',
        telephone: '0033199999999',
        mobile_telephone: '',
        contact_id: 322,
        address_line3: 'Paris',
        company_name: 'Generic Distribution',
        country_id: 73,
        address_line4: 'Paris',
        email: 'accounts@example.com',
        address_line2: '',
        address_full_name: 'Billing',
        address_line1: '1, rue de Rivoli',
        postal_code: '75000'
      }
    }
  end

  subject { described_class.new(params) }

  %w/Delivery Customer Billing/.each do |type|
    context "with a #{type.downcase} address" do
      let(:contact) { subject.send(type.downcase.to_sym) }

      it 'should be a Contact' do
        expect(contact).to be_a(Nacre::Order::Contact)
      end

      it "should be the #{type} contact" do
        expect(contact.address_full_name).to eq(type)
      end
    end
  end

  it_behaves_like 'Parametrizable'
end
