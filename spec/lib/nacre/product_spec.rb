require 'spec_helper'

describe 'Nacre::Product' do

  let(:valid_params) do
    {
      product_id: 1,
      brand_id: 2,
      product_type_id: 3,
      identity: {},
      product_group_id: 4,
      stock: {},
      financial_details: {},
      sales_channels: {},
      composition: {},
      variations: []
    }
  end

  context 'initialization' do

    describe '.new' do
      let(:subject) { Nacre::Product.new(valid_params) }

      it 'should have a product_id' do
        expect(subject.product_id).to eql(valid_params[:product_id])
      end
    end

    describe '.from_json' do
      let(:json) { fixture_file_content('product.json') }
      let(:subject) { Nacre::Product.from_json(json) }

      it 'should have an product_id' do
        expect(subject.product_id).to eql(1008)
      end
    end
  end

  describe '#params' do
    let(:subject) { Nacre::Product.new(valid_params) }

    it 'should output a hash identical to the input hash' do
      expect(subject.params).to eql(valid_params)
    end
  end
end
