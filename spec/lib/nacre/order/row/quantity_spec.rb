require 'spec_helper'

describe Nacre::Order::Row::Quantity do

  let(:params) { { magnitude: '3.000000' } }

  subject { described_class.new(params) }

  it 'should have the magnitude (actual quantity multiplier)' do
    expect(subject.magnitude).to eq('3.000000')
  end

  it_behaves_like 'Parametrizable'
end
