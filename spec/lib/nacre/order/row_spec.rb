require 'spec_helper'

describe Nacre::Order::Row do
  let(:key) { '4431' }

  let(:params) do
    {
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
          value: '25.000000'
        },
        tax_rate: '0.000000'
      }
    }
  end

  subject { described_class.new(key,params) }

  it_behaves_like 'Parametrizable'

  it 'should have a key' do
    expect(subject.key).to eq('4431')
  end

  it 'should have a product SKU' do
    expect(subject.product_sku).to eq('TCX99D')
  end

  it 'should have product options' do
    expect(subject.product_options).to be_a(Nacre::Order::Row::ProductOptions)
  end

  it 'should have a quantity' do
    expect(subject.quantity).to be_a(Nacre::Order::Row::Quantity)
  end

  it 'should have a product ID' do
    expect(subject.product_id).to eq(1057)
  end

  it 'should have a product name' do
    expect(subject.product_name).to eq('Able Bodies - Important Record CD')
  end

  it 'should have a nominal code' do
    expect(subject.nominal_code).to eq('4000')
  end

  it 'should have an order row sequence' do
    expect(subject.order_row_sequence).to eq('20')
  end

  it 'should have composition details' do
    expect(subject.composition).to be_a(Nacre::Order::Row::CompositionDetails)
  end

  it 'should have a row value' do
    expect(subject.row_value).to be_a(Nacre::Order::Row::Value)
  end
end
