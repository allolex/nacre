require 'spec_helper'

describe Nacre::Order::RowCollection do
  let(:params) do
    {
      '4431' => {
          product_sku: 'TCX99D',
          product_options: {
          discs: '1disc'
        },
        quantity: {
          magnitude: '3.000000'
        },
        product_id: 1057,
        product_name: 'Able Bodies - Important Record CD',
        nominal_code: '4000',
        order_row_sequence: '20',
        composition: {
          bundle_child: false,
          parent_order_row_id: 0,
          bundle_parent: false
        },
        row_value: {
          row_tax: {
            currency_code: 'EUR',
            value: '0.000000'
          },
          tax_code: 'T4',
          row_net: {
            currency_code: 'EUR',
            value: '25.500000'
          },
          tax_rate: '0.000000'
        }
      },
      '4430' => {
        product_sku: '28999-black',
        product_options: {
          disk: '2disks',
          diameter: '12in',
          colour: 'Black'
        },
        quantity: {
          magnitude: '1.000000'
        },
        product_id: 1373,
        product_name: 'Arthur - Friendly Policeman LP',
        nominal_code: '4000',
        order_row_sequence: '10',
        composition: {
          bundle_child: false,
          parent_order_row_id: 0,
          bundle_parent: false
        },
        row_value: {
          row_tax: {
            currency_code: 'EUR',
            value: '0.000000'
          },
          tax_code: 'T4',
          row_net: {
            currency_code: 'EUR',
            value: '12.250000'
          },
          tax_rate: '0.000000'
        }
      }
    }
  end

  subject { described_class.new(params) }

  it_should_behave_like 'Enumerable'

  it_should_behave_like 'Parametrizable'

  it 'should be a collection of Order::Row' do
    expect(subject.first).to be_a(Nacre::Order::Row)
  end
end

