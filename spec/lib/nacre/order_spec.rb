require 'spec_helper'

describe Nacre::Order do

  let!(:link) { Nacre::Connection.new }

  describe 'initialization' do

    let(:order) { Nacre::Order.new(params) }

    let(:params) do
      {
        order_id: 123456,
        parent_order_id: 123455
      }
    end

    let(:order) { Nacre::Order.new(params) }

    it 'should have an order_id' do
      expect(order.order_id).to eql(123456)
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql(123455)
    end
  end

  describe '.from_json' do

    let(:json) { fixture_file_content('order.json') }

    let(:order) { Nacre::Order.from_json(json) }

    it 'should have an order_id' do
      expect(order.order_id).to eql(123456)
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql(123455)
    end
  end

  describe '#params' do

    context 'with all the valid params' do
      let(:valid_params) {
        {
                           :order_id => "570001",
                    :parent_order_id => "",
                      :order_type_id => "1",
                         :contact_id => "298",
                    :order_status_id => "3",
              :order_stock_status_id => "1",
                         :created_on => "2012-07-25T13:10:12.000Z",
                      :created_by_id => "203",
                       :customer_ref => "",
            :order_payment_status_id => "3"
        }
      }

      let(:order) { Nacre::Order.new(valid_params) }

      it 'should output a hash identical to the input hash' do
        expect(order.params).to eql(valid_params)
      end

    end
  end

  describe '.find' do

    context 'by ID' do
      let(:id_text) { 123456 }
      let(:orders) { Nacre::Order.find(id: id_text) }

      before do
        stub_request(:get, "https://ws-eu1.brightpearl.com/%s/%s/order-service/order-search" % [Nacre.configuration.api_version, Nacre.configuration.user_id]).
          to_return(:status => 200, :body => fixture_file_content('order_search_result.json') , :headers => {})
      end

      it 'should return search results' do
        expect(orders).to be_a(Nacre::OrderSearchResults)
      end

      it 'should find an order with the correct ID' do
        expect(orders.first[:order_id]).to eql(id_text.to_s)
      end
    end

    context 'by date' do
      let(:date_text) { '2012-12-14' }
      let(:date) { Date.new(date: date_text) }
      let(:orders) { Nacre::Order.find(date_text) }

      before do
        stub_request(:get, "https://ws-eu1.brightpearl.com/%s/%s/order-service/order-search" % [Nacre.configuration.api_version, Nacre.configuration.user_id]).
          to_return(:status => 200, :body => fixture_file_content('order_search_result_by_date.json') , :headers => {})
      end

      it 'should return search results' do
        expect(orders).to be_a(Nacre::OrderSearchResults)
      end

      it 'should get the right number of orders back' do
        expect(orders.count).to eql(2)
      end

      it 'should get a list of orders on the date provided' do
        orders.each do |order|
          expect(order[:created_on]).to match(date_text)
        end
      end
    end
  end
end
