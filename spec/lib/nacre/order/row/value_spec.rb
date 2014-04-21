require 'spec_helper'

describe Nacre::Order::Row::Value do

  let(:params) do
    {
      row_tax: {
        currency_code: 'EUR',
        value: '0.000000'
      },
      tax_code: 'T4',
      row_net: {
        currency_code: 'EUR',
        value: '25.000000'
      },
      tax_rate: '2.000000'
    }
  end

  subject { described_class.new(params) }

  it_should_behave_like 'Parametrizable'

  context 'using the default params' do
    describe '#tax_code' do
      it 'should return the value set in the params hash' do
        expect(subject.tax_code).to eq('T4')
      end
    end

    describe '#tax_rate' do
      it 'should return the value set in the params hash' do
        expect(subject.tax_rate).to eq('2.000000')
      end
    end

    describe '#tax_rate_raw' do
      it 'should return 1_000_000 times the value set in the params hash' do
        expect(subject.tax_rate_raw).to eq(2000000)
      end
    end

    describe '#row_tax' do
      it 'should return a tax amount' do
        expect(subject.row_tax).to be_a(Nacre::Order::Row::Amount)
      end
    end

    describe '#row_net' do
      it 'should return a net amount' do
        expect(subject.row_net).to be_a(Nacre::Order::Row::Amount)
      end
    end
  end
end
