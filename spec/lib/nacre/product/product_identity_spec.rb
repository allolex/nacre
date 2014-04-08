require 'spec_helper'

describe Nacre::Product::Identity do

  let(:params) do
    {
      sku: "SKU0001",
      isbn: "0-684-84328-5",
      ean: "ISNB0-9712345-",
      upc: "5778400001",
      barcode: "738737638"
    }
  end

  subject { Nacre::Product::Identity.new(params) }

  describe 'attributes' do

    it 'can have a sku' do
      expect(subject.sku).to eql(params[:sku])
    end

    it 'must have an isbn' do
      expect(subject.isbn).to eql(params[:isbn])
    end

    it 'must have an ean' do
      expect(subject.ean).to eql(params[:ean])
    end

    it 'can have a upc' do
      expect(subject.upc).to eql(params[:upc])
    end

    it 'can have a barcode' do
      expect(subject.barcode).to eql(params[:barcode])
    end
  end

  describe '#params' do
    it 'should output the same parameters as in the input' do
      expect(subject.params).to eql(params)
    end
  end

end
