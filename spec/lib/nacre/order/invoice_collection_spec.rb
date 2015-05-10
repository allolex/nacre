require "spec_helper"

describe Nacre::Order::InvoiceCollection do
  let(:params) do
    [
      {
        due_date: "2013-02-04T00:00:00.000Z",
        invoice_reference: "AA-99999",
        tax_date: "2012-12-06T00:00:00.000Z"
      }
    ]
  end

  subject { described_class.new(params) }

  it_behaves_like "Enumerable"

  it_behaves_like "Parametrizable"

  it "should contain invoices" do
    expect(subject.first).to be_a(Nacre::Order::Invoice)
  end
end
