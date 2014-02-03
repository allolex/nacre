require 'spec_helper'

describe Nacre::Order do

  let(:json) { fixture_file_content('order.json') }
  let(:order_hash) { JSON.parse(json)['response'].first }
  let(:order) { Nacre::Order.new(order_hash) }

  describe 'attributes' do
    it 'should have an id' do
      expect(order.id).to eql('123456')
    end

    it 'should have a parent_order_id' do
      expect(order.parent_order_id).to eql('123455')
    end
  end

  # describe '.find' do
  #   it 'should return the correct order' do
  #     bp = Nacre::Order.find('123456')
  #     expect(bp.id).to eql('123456')
  #   end
  # end
end
