require 'spec_helper'

describe Nacre::ColumnProperty do
  let(:params) do
    {
      name: 'orderId',
      sortable: true,
      filterable: true,
      report_data_type: 'INTEGER',
      required: false
    }
  end

  subject { described_class.new(params) }

  describe '#name' do
    it 'should return the Brightpearl column name' do
      expect(subject.name).to eq('orderId')
    end
  end

  describe '#formatted_name' do
    it 'should return snake case column name as a symbol' do
      expect(subject.formatted_name).to eq(:order_id)
    end
  end

  describe '#sortable' do
    it 'should be the correct value' do
      expect(subject.sortable).to eq(true)
    end
  end

  describe '#filterable' do
    it 'should be the correct value' do
      expect(subject.filterable).to eq(true)
    end
  end

  describe '#report_data_type' do
    it 'should return a string containing the Brightpearl data type' do
      expect(subject.report_data_type).to eq('INTEGER')
    end
  end

  describe '#required' do
    it 'should be the correct value' do
      expect(subject.required).to eq(false)
    end
  end
end
