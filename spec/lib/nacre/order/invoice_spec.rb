require 'spec_helper'

describe Nacre::Order::Invoice do
  let(:params) do
    {
      due_date: '2013-02-04T00:00:00.000Z',
      invoice_reference: 'AA-99999',
      tax_date: '2012-12-06T00:00:00.000Z'
    }
  end

  subject { described_class.new(params) }

  it 'should have a due date' do
    expect(subject.due_date).to be_a(DateTime)
    expect(subject.due_date.to_s).to eq('2013-02-04T00:00:00+00:00')
  end

  it 'should have an invoice reference' do
    expect(subject.invoice_reference).to eq('AA-99999')
  end

  it 'should have a tax date' do
    expect(subject.tax_date).to be_a(DateTime)
    expect(subject.tax_date.to_s).to eq('2012-12-06T00:00:00+00:00')
  end

end
