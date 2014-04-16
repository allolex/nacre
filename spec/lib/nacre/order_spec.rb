require 'spec_helper'

describe Nacre::Order do

  let!(:link) { Nacre::Connection.new }

  describe 'initialization' do

    context 'with simple params' do
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

    context 'with complex params' do
      let(:fixture_file_name) { 'order_music.json' }

      subject do
        described_class.from_json(
          fixture_file_content(fixture_file_name)
        )
      end

      it 'should have the correct order_id' do
        expect(subject.id).to eq(999999)
      end

      it 'should have the correct parent order ID' do
        expect(subject.parent_order_id).to eq(0)
      end

      it 'should have the correct warehouse ID' do
        expect(subject.warehouse_id).to eq(8)
      end

      it 'should have the reference' do
        expect(subject.reference).to eq('')
      end

      it 'should have the price mode code' do
        expect(subject.price_mode_code).to eq('EXC')
      end

      it 'should have the allocation status code' do
        expect(subject.allocation_status_code).to eq('AAA')
      end

      it 'should have the currency set' do
        expect(subject.currency).to be_a(Nacre::Order::Currency)
      end

      it 'should have the acknowledged flag' do
        expect(subject.acknowledged).to eq(0)
      end

      it 'should have the date the order was placed' do
        expect(subject.placed_on).to be_a(DateTime)
      end

      it 'should have the order status' do
        expect(subject.order_status).to be_a(Nacre::Order::Status)
      end

      it 'should have the invoices' do
        expect(subject.invoices).to be_a(Nacre::Order::InvoiceCollection)
      end

      it 'should have the payment status' do
        expect(subject.order_payment_status).to eq('UNPAID')
      end

      it 'should have an empty "null custom fields" list' do
        expect(subject.null_custom_fields).to eq(nil)
      end

      it 'should have the price list ID' do
        expect(subject.price_list_id).to eq(7)
      end

      it 'should have the id of the user who created it' do
        expect(subject.created_by_id).to eq(208)
      end

      it 'should have the cost price list ID' do
        expect(subject.cost_price_list_id).to eq(1)
      end

      it 'should have the shipping status code' do
        expect(subject.shipping_status_code).to eq('ASS')
      end

      it 'should have the stock status code' do
        expect(subject.stock_status_code).to eq('SOA')
      end
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
