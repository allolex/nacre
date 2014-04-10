require 'spec_helper'

describe 'Nacre::Product' do

  let(:params) do
    {
      product_id: 1,
      brand_id: 2,
      product_type_id: 3,
      identity: {sku: nil, isbn: nil, ean: nil, upc: nil,barcode: nil},
      product_group_id: 4,
      stock: { stock_tracked: false },
      financial_details: { tax_code: { id: nil, code: nil } },
      sales_channels: [],
      composition: {},
      variations: []
    }
  end

  subject { Nacre::Product.new(params) }

  it_should_behave_like 'Parametrizable'

  context 'initialization' do

    describe '.new' do
      it 'should have a product_id' do
        expect(subject.product_id).to eql(params[:product_id])
      end
    end

    describe '.from_json' do
      let(:json) { fixture_file_content('product.json') }

      subject { Nacre::Product.from_json(json) }

      it 'should have the correct product_id' do
        expect(subject.product_id).to eql(1008)
      end

      it 'should have the correct brand_id' do
        expect(subject.brand_id).to eql(74)
      end

      it 'should have an identity' do
        expect(subject.identity).to be_a(Nacre::Product::Identity)
      end

      it 'should have financial_details' do
        expect(subject.financial_details).to be_a(Nacre::Product::FinancialDetails)
      end

      it 'should have stock details' do
        expect(subject.stock).to be_a(Nacre::Product::StockDetails)
      end

      it 'should have the sales channels' do
        expect(subject.sales_channels).to be_a(Nacre::Product::SalesChannelCollection)
      end
    end
  end


    end
  end
end
