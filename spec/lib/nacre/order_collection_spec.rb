require 'spec_helper'

describe Nacre::OrderCollection do

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
end
