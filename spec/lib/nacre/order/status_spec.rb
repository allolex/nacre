require "spec_helper"

describe Nacre::Order::Status do
  let(:params) do
    {
      order_status_id: 4,
      name: "invoiced"
    }
  end

  subject { described_class.new(params) }

  it "should have an order status ID" do
    expect(subject.order_status_id).to eq(4)
  end

  it "should have a name" do
    expect(subject.name).to eq("invoiced")
  end

  it_behaves_like "Parametrizable"
end
