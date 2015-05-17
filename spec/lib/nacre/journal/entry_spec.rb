require "spec_helper"

describe Nacre::Journal::Entry do
  let(:params) do
    {
      nominal_code: "1001",
      change: {
          value: "99.99"
      },
      assignment: {
          channel_id: 3,
          lead_source_id: 3,
          project_id: 100,
      },
      order_id: 999999,
      tax_code: "T9"
    }
  end

  subject { described_class.new(params) }

  it_behaves_like "Parametrizable"

  it "has a nominal code" do
    expect(subject.nominal_code).to eq "1001"
  end

  it "has an order_id" do
    expect(subject.order_id).to eq 999999
  end

  it "has a tax_code" do
    expect(subject.tax_code).to eq "T9"
  end

  describe "change convenience readers" do
    it "has a value" do
      expect(subject.value).to eq BigDecimal.new("99.99")
    end

    it "has a BigDecimal value" do
      expect(subject.value).to be_a BigDecimal
    end
  end

  describe "assignment convenience readers" do
    it "has a project_id" do
      expect(subject.project_id).to eq 100
    end

    it "has a channel_id" do
      expect(subject.channel_id).to eq 3
    end
  end
end
