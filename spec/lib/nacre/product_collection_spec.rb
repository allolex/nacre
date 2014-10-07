require 'spec_helper'

describe Nacre::ProductCollection do

  let(:parametrized_list) do
    [
      {
        product_id: '123444',
      }
    ]
  end

  let(:subject) { Nacre::ProductCollection.new(parametrized_list) }

  it_behaves_like 'Enumerable'

  context 'initialization' do

    describe '.new' do
      it 'should create a list of Products' do
        expect(subject.first).to be_a(Nacre::Product)
      end
    end

    describe '.from_json' do
      let(:json) { fixture_file_content('product.json') }
      let(:subject) { Nacre::ProductCollection.from_json(json) }

      it 'should be a list of Products' do
        expect(subject.first).to be_a(Nacre::Product)
      end
    end
  end

  describe '.get' do

    let(:range) { '990071,990294,990458,990595,991847' }

    let(:get_options) do
      {
        search_url: product_service_url,
        ids: range,
        options: [
          'customFields',
          'nullCustomFields'
        ]
      }
    end

    before do
      @url = Nacre::RequestUrl.new(get_options)
      stub_request(
        :get,
        @url.to_s
      ).to_return(
        status: 200,
        body: fixture_file_content('product_collection.json'),
        headers: {}
      )
      @collection = described_class.get(range)
    end

    it 'should query the API server' do
      expect(a_request(:get, @url.to_s)).to have_been_made
    end

    it 'should return a valid ProductCollection' do
      expect(@collection).to be_a(Nacre::ProductCollection)
    end

    it 'should contain the fixture products' do
      expect(@collection.first).to be_a(Nacre::Product)
    end
  end
end
