require 'spec_helper'

describe Nacre::Order::Currency do

  let(:params) do
    {
      exchange_rate: '1.234900',
      order_currency_code: 'EUR',
      accounting_currency_code: 'GBP'
    }
  end

  subject { described_class.new(params) }

  it 'should have an exchange rate' do
    expect(subject.exchange_rate).to eq('1.234900')
  end

  it 'should have an order currency code' do
    expect(subject.order_currency_code).to eq('EUR')
  end

  it 'should have an accounting currency code' do
    expect(subject.accounting_currency_code).to eq('GBP')
  end
end
