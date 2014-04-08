require 'spec_helper'

describe Nacre::Product::TaxCode do
  let(:params) do
    {
      id: 7,
      code: "T20"
    }
  end

  subject { Nacre::Product::TaxCode.new(params) }

  describe 'attributes' do
    it 'should have an id' do
      expect(subject.id).to eql(params[:id])
    end

    it 'should have a code' do
      expect(subject.code).to eql(params[:code])
    end
  end

  it_should_behave_like 'Parametrizable'
end
