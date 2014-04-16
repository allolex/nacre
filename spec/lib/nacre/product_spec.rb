require 'spec_helper'

describe 'Nacre::Product' do

  let(:params) do
    {
      id: 1,
      brand_id: 2,
      product_type_id: 3,
      product_group_id: 4,
      stock: { stock_tracked: false },
    }
  end

  subject { Nacre::Product.new(params) }

  it_should_behave_like 'Parametrizable'

  context 'initialization' do

    describe '.new' do
      it 'should have an id' do
        expect(subject.id).to eql(params[:id])
      end
    end

    describe '.from_json' do
      let(:json) { fixture_file_content('product.json') }

      subject { Nacre::Product.from_json(json) }

      it 'should have the correct id' do
        expect(subject.id).to eql(1008)
      end

      it 'should have the correct brand_id' do
        expect(subject.brand_id).to eql(74)
      end

      it 'should have an identity' do
        expect(subject.identity).to be_a(Nacre::Product::Identity)
      end

      it 'should have financial_details' do
        expect(subject.financial_details).to be_a(
          Nacre::Product::FinancialDetails
        )
      end

      it 'should have stock details' do
        expect(subject.stock).to be_a(Nacre::Product::StockDetails)
      end

      it 'should have the sales channels' do
        expect(subject.sales_channels).to be_a(
          Nacre::Product::SalesChannelCollection
        )
      end
    end
  end

  describe '.find' do

    context 'by ID' do
      let(:id_text) { 1000 }
      let(:products) { Nacre::Product.find(id_text) }

      before do
        stub_request(
          :get,
          "#{product_search_url}?productId=%s" % [id_text]
        ).to_return(
          status: 200,
          body: fixture_file_content('product_search_result.json') ,
          headers: {}
        )
      end

      it 'should return search results' do
        expect(products).to be_a(Nacre::SearchResults)
      end

      it 'should find an order with the correct ID' do
        expect(products.first[:product_id]).to eql(id_text.to_s)
      end
    end
  end

  describe '#name' do
    context 'when the Brightpearl sales channel product name is defined' do
      let(:json) { fixture_file_content('product_music.json') }

      subject { Nacre::Product.from_json(json) }

      it 'should have the correct name' do
        expect(subject.name).to eq('An Artist - A Title EP')
      end
    end

    context 'when the Brightpearl sales channel product name is not defined' do
      subject { Nacre::Product.new(params) }

      it 'should not have a defined name' do
        expect(subject.name).to be_nil
      end

    end
  end

  context 'with custom fields' do
    let(:json) { fixture_file_content('product_with_custom_fields.json') }

    subject { Nacre::Product.from_json(json) }

    it 'should have a custom fields hash attribute' do
      expect(subject.custom_fields).to be_a(Hash)
    end

    it 'should have the null custom fields array attribute' do
      expect(subject.null_custom_fields).to be_a(Array)
    end
  end

  context 'API interactions' do
    let!(:link) { Nacre::Connection.new }

    let(:resource) { 'product' }

    let(:api_details) do
      [
        Nacre.configuration.api_version,
        Nacre.configuration.user_id
      ]
    end

    describe '.get' do
      let(:resource_endpoint) {
        product_service_url
      }

      let(:range) { 1018 }

      let(:options) { 'includeOptional=customFields,nullCustomFields' }

      it 'should make a request to the correct endpoint' do
        stub_request(:get, "#{resource_endpoint}/#{range}?#{options}").
          to_return(
            status:  200,
            body:  fixture_file_content('product_with_custom_fields.json'),
            headers:  {}
          )

        product = Nacre::Product.get(1018)

        a_request(
          :get,
          "#{resource_endpoint}/#{range}?#{options}"
        ).should have_been_made

        expect(product.id).to eql(1018)
      end
    end
  end
end
