require "spec_helper"

describe Nacre::Journal::EntryCollection do
  let(:params) do
    [
      {
        nominal_code: "1001",
        change: {
            value: "99.99"
        },
        assignment: {
            channel_id: 3,
            lead_source_id: 3
        },
        order_id: 999999,
        tax_code: "T9"
      }
    ]
  end

  shared_examples_for "Entry Collection" do
    subject { described_class.new(params, type: type) }

    it_behaves_like "Enumerable"

    it_behaves_like "Parametrizable"

    it "should contain invoices" do
      expect(subject.first).to be_a(Nacre::Journal::Entry)
    end

    it "has the correct type" do
      expect(subject.type).to eq type
    end
  end

  context "with credit entries" do
    let(:type) { :credit }

    it_behaves_like "Entry Collection"
  end

  context "with debit entries" do
    let(:type) { :debit }

    it_behaves_like "Entry Collection"
  end
end
