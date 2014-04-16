require 'spec_helper'

describe Nacre::Order do

  let!(:link) { Nacre::Connection.new }

  describe 'initialization' do

    let(:order) { Nacre::Order.new(params) }

    let(:params) do
      {
        id: 123456,
        parent_order_id: 123455
      }
    end

    let(:order) { Nacre::Order.new(params) }

    it 'should have an order_id' do
      expect(order.id).to eql(123456)
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql(123455)
    end
  end

  describe '.from_json' do

    let(:json) { fixture_file_content('order.json') }

    let(:order) { Nacre::Order.from_json(json) }

    it 'should have an id' do
      expect(order.id).to eql(123456)
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql(123455)
    end
  end

  describe '#params' do

    context 'with all the valid params' do
      let(:valid_params) {
        {
          id:  '570001',
          parent_order_id:  '',
          order_type_id:  '1',
          contact_id:  '298',
          order_status_id:  '3',
          order_stock_status_id:  '1',
          created_on:  '2012-07-25T13:10:12.000Z',
          created_by_id:  '203',
          customer_ref:  '',
          order_payment_status_id:  '3'
        }
      }

      let(:order) { Nacre::Order.new(valid_params) }

      it 'should output a hash identical to the input hash' do
        expect(order.params).to eql(valid_params)
      end
    end
  end

  describe '.get' do
    let(:resource_endpoint) { order_service_url }
    let(:range) { 999999 }
    let(:url) { "#{resource_endpoint}/#{range}?includeOptional=customFields,nullCustomFields" }
    let(:fixture_file_name) { 'order_music.json' }

    it 'should make a request to the correct endpoint' do
      stub_request(:get, url).
        to_return(
          status:  200,
          body:  fixture_file_content(fixture_file_name),
          headers:  {}
        )
      resource = described_class.get(range)
      a_request(:get, url).should have_been_made
      expect(resource.id).to eql(range)
    end
  end

  describe '.find' do
    context 'by ID' do
      let(:id_text) { 123456 }
      let(:orders) { Nacre::Order.find(id_text) }

      before do
        stub_request(
          :get,
         "#{order_search_url}?orderId=%s" % [id_text]
        ).to_return(
          status: 200,
          body: fixture_file_content('order_search_result.json'),
          headers: {}
        )
      end

      it 'should return search results' do
        expect(orders).to be_a(Nacre::SearchResults)
      end

      it 'should find an order with the correct ID' do
        expect(orders.first[:order_id]).to eql(id_text.to_s)
      end
    end
  end
end
