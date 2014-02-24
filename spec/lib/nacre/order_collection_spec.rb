require 'spec_helper'

describe Nacre::OrderCollection do

  describe '#orders' do

    let(:parametrized_order_list) do
      [
        {
          order_id: '123444',
          parent_order_id: '555555'
        }
      ]
    end

    let(:subject) { Nacre::OrderCollection.new(parametrized_order_list) }

    let(:order) { subject.members.first }

    it 'should have members' do
      expect(order.id).to eql('123444')
      expect(order.parent_order_id).to eql('555555')
    end

    it_should_behave_like 'Enumerable'
  end

  describe '.from_json' do

    let(:orders_json) { fixture_file_content('order.json') }
    let(:orders) { Nacre::OrderCollection.from_json(orders_json) }

    describe '.members' do
      let(:order) { orders.members.first }

      it 'should be a list of order-like objects' do
        expect(order.id).to eql('123456')
        expect(order.parent_order_id).to eql('123455')
      end
    end
  end
end
