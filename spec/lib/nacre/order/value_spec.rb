require 'spec_helper'

describe Nacre::Order::Value do
  let(:params) do
    {
      base_net: '25.31',
      base_tax_amount: '0.00',
      tax_amount: '0.00',
      net: '31.25'
    }
  end

  subject { described_class.new(params) }

  it 'should have a base net amount' do
    expect(subject.base_net).to eq('25.31')
  end

  it 'should have a base tax amount' do
    expect(subject.base_tax_amount).to eq('0.00')
  end

  it 'should have a tax amount' do
    expect(subject.tax_amount).to eq('0.00')
  end

  it 'should have a net amount' do
    expect(subject.net).to eq('31.25')
  end

  it_behaves_like 'Parametrizable'
end
