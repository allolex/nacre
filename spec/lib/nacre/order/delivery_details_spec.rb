require 'spec_helper'

describe Nacre::Order::DeliveryDetails do
  let(:params) do
    {
      shipping_method_id: 0
    }
  end

  subject { described_class.new(params) }

  it 'should have a shipping method id' do
    expect(subject.shipping_method_id).to eq(0)
  end

  it_should_behave_like 'Parametrizable'
end
