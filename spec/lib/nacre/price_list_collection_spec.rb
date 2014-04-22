require 'spec_helper'

describe Nacre::PriceListCollection do

  let(:params) do
    [
      {
        price_list_id: 0,
        currency_code: 'GBP',
        quantity_price: {
          '1' => '10',
          '5' => '9.555',
          '15' => '9',
          '25' => '8',
          '50' => '7.5',
          '200' => '7'
        }
      },
      {
        price_list_id: 1,
        currency_code: 'GBP',
        quantity_price: {
          '1' => '12',
          '100' => '11',
          '1000' => '10',
          '5000' => '9.5'
        }
      },
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
    ]
  end

  subject { described_class.new(params) }

  it_should_behave_like 'Enumerable'

  it_should_behave_like 'Parametrizable'

  it 'should be a collection of price lists' do
    expect(subject.first).to be_a(Nacre::PriceList)
  end
end
