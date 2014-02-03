require 'spec_helper'

describe Nacre::OrderCollection do

  let(:orders_json) { fixture_file_content('order.json') }
  let(:orders) { Nacre::OrderCollection.new(orders_json) }

  it 'should implement .each' do
    expect(orders).to respond_to(:each)
  end

  it 'should implement .map' do
    expect(orders).to respond_to(:map)
  end

  describe '.members' do
    it 'should be a list of order-like objects' do
      expect(orders.members.first).to respond_to(:id)
      expect(orders.members.first).to respond_to(:parent_order_id)
    end
  end
end
