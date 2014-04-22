require 'spec_helper'

describe Nacre::PriceList do
  let(:params) do
    {
      price_list_id: 2,
      currency_code: 'GBP',
      quantity_price: {
        '1' => '12.5000',
        '5' => '12.3333',
        '25' => '11.6667',
        '50' => '12.3333',
        '150' => '11.6667',
        '250' => '10.8333'
      }
    }
  end

  subject { described_class.new(params) }

  describe '#price_list_id' do
    it 'should have the correct value' do
      expect(subject.price_list_id).to eq(2)
    end
  end

  describe '#currency_code' do
    it 'should be the correct currency code' do
      expect(subject.currency_code).to eq('GBP')
    end
  end

  describe '#quantity_price' do
    it 'should be a Hash' do
      expect(subject.quantity_price).to be_a(Hash)
    end

    it 'should contain price break information' do
      expect(subject.quantity_price['50']).to eq('12.3333')
    end
  end
end
