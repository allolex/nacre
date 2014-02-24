require 'spec_helper'

describe Nacre::Order do

  let!(:link) { Nacre::Connection.new }

  describe 'attributes' do

    let(:params) do
      {
        id: 123456,
        parent_order_id: 123455
      }
    end

    let(:order) { Nacre::Order.new(params) }

    it 'should have an id' do
      expect(order.id).to eql('123456')
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql('123455')
    end
  end

  describe '.from_json' do

    let(:json) { fixture_file_content('order.json') }

    let(:order) { Nacre::Order.from_json(json) }

    it 'should have an id' do
      expect(order.id).to eql('123456')
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql('123455')
    end
  end

  describe '.find' do

    before do
      stub_request(:get, "https://ws-eu1.brightpearl.com/order-service/order-search").
        to_return(:status => 200, :body => fixture_file_content('order_search_result.json') , :headers => {})
    end

    let(:order) { Nacre::Order.find('123456') }

    it 'should return search results' do
      expect(order).to be_a(Nacre::OrderSearchResults)
    end
  end
end
