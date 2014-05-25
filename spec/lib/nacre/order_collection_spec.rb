require 'spec_helper'

describe Nacre::OrderCollection do

  let!(:link) { Nacre::Connection.new }

  let(:parametrized_order_list) do
    [
      {
        order_id: '123444',
        parent_order_id: '555555'
      }
    ]
  end

  let(:subject) { Nacre::OrderCollection.new(parametrized_order_list) }

  it_should_behave_like 'Enumerable'

  context 'initialization' do

    describe '.new' do
      it 'should create a list of Orders' do
        expect(subject.first).to be_a(Nacre::Order)
      end
    end

    describe '.from_json' do
      let(:orders_json) { fixture_file_content('order.json') }
      let(:subject) { Nacre::OrderCollection.from_json(orders_json) }

      it 'should be a list of Orders' do
        expect(subject.first).to be_a(Nacre::Order)
      end
    end
  end

  describe '.get' do

    let(:range) { '990071,990294,990458,990595,991847' }

    let(:get_options) do
      {
        search_url: order_service_url,
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
        body: fixture_file_content('orders_collection.json'),
        headers: {}
      )
      @collection = described_class.get(range)
    end


    it 'should query the API server' do
      expect(a_request(:get, @url.to_s)).to have_been_made
    end

    it 'should return a valid OrderCollection' do
      expect(@collection).to be_a(Nacre::OrderCollection)
    end

    it 'should contain the fixture orders' do
      expect(@collection.first).to be_a(Nacre::Order)
    end
  end
end
