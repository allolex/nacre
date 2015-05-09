require "spec_helper"

describe Nacre::Order::Row::ProductOptions do

  let(:params) { { discs: "1disc" } }

  subject { described_class.new(params) }

  it "should have the disc count" do
    expect(subject.discs).to eq("1disc")
  end

  it_behaves_like "Parametrizable"
end
