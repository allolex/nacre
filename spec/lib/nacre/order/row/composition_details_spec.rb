require "spec_helper"

describe Nacre::Order::Row::CompositionDetails do

  let(:params) do
    {
      bundle_child: false,
      parent_order_row_id: 0,
      bundle_parent: false
    }
  end

  subject { described_class.new(params) }

  describe "#bundle_child", method_name: :bundle_child do
    it_behaves_like "a boolean attribute"
  end

  describe "#bundle_parent", method_name: :bundle_parent do
    it_behaves_like "a boolean attribute"
  end

  it "should indicate a parent order row id" do
    expect(subject.parent_order_row_id).to eq(0)
  end

  it_behaves_like "Parametrizable"
end
