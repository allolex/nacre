require 'spec_helper'

describe Nacre::Product::FinancialDetails do
  let(:params) do
    {
      tax_code: {
        id: 7,
        code: "T20"
      }
    }
  end

  subject { Nacre::Product::FinancialDetails.new(params) }

  describe 'attributes' do
    it 'should have a tax code' do
      expect(subject.tax_code).to be_a(Nacre::Product::TaxCode)
    end
  end

  it_should_behave_like 'Parametrizable'

end
