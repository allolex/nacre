require "spec_helper"

describe Nacre::Order::Invoice do
  let(:params) do
    {
      due_date: "2013-02-04T00:00:00.000Z",
      invoice_reference: "AA-99999",
      tax_date: "2012-12-06T00:00:00.000Z"
    }
  end

  subject { described_class.new(params) }

  describe "#invoice_reference" do
    it "should have the correct value" do
      expect(subject.invoice_reference).to eq("AA-99999")
    end
  end

  describe "#due_date" do
    it "should be formatted correctly" do
      expect(subject.due_date.to_s).to eq("2013-02-04T00:00:00.000Z")
    end
  end

  describe "#due_date_raw" do
    it "should return a DateTime object" do
      expect(subject.due_date_raw).to be_a(DateTime)
    end
  end

  describe "#tax_date" do
    it "should be formatted correctly" do
      expect(subject.tax_date.to_s).to eq("2012-12-06T00:00:00.000Z")
    end
  end

  describe "#tax_date_raw" do
    it "should return a DateTime object" do
      expect(subject.tax_date_raw).to be_a(DateTime)
    end
  end
end
