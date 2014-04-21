require 'spec_helper'

describe Nacre::Order::Row::Amount do
  let(:params) do
    {
      currency_code: 'EUR',
      value: '25.000000'
    }
  end

  subject { described_class.new(params) }

  it_should_behave_like 'Parametrizable'

  describe '#currency_code' do
    it 'should be set to EUR' do
      expect(subject.currency_code).to eq('EUR')
    end
  end

  describe '#value' do
    it 'should be set to 25.000000' do
      expect(subject.value).to eq('25.000000')
    end
  end

  describe '#value_raw' do
    it 'should be set to 25000000' do
      expect(subject.value_raw).to eq(25000000)
    end
  end
end
