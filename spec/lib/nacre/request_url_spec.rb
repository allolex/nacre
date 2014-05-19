require 'spec_helper'

describe Nacre::RequestUrl do
  let(:search_url) { order_search_url }

  let(:id_field) { 'orderId' }

  let(:valid_params) do
    {
      search_url: search_url,
      fields: {
        order_id: 1
      },
      pagination: {
        first_record: 1,
        window: 100
      },
      options: [
        'customFields',
        'nullCustomFields'
      ]
    }
  end

  let(:invalid_params) { {} }

  subject { described_class.new(params) }

  context 'with valid params' do

    let(:params) { valid_params }

    describe '#search_url' do
      it 'should return the search base URL' do
        expect(subject.search_url).to eq(search_url)
      end
    end

    describe '#fields' do
      it 'should return URL encoded fields and values' do
        expect(subject.fields).to eq(['orderId=1'])
      end
    end

    describe '#fields=' do
      it 'should take a hash' do
        field_params = {
          order_id: 2,
          order_parent_id: 4
        }
        subject.fields = field_params
        expect(subject.fields).to eq(
          ['orderId=2','orderParentId=4']
        )
      end
    end

    describe '#pagination' do
      it 'should return a URL encoded string' do
        expect(subject.pagination).to eq(
          ['firstResult=1','pageSize=100']
        )
      end
    end

    describe '#pagination_params' do
      it 'should return a hash of pagination options' do
        expect(subject.pagination_params).to eq(
          { first_record: 1, window: 100 }
        )
      end
    end

    describe '#pagination=' do
      it 'should take a hash' do
        subject.pagination = { first_record: 11, window: 10 }
        expect(subject.pagination).to eq(
          ['firstResult=11','pageSize=10']
        )
      end
    end

    describe '#options' do
      it 'should return an encoded "includeOptional" assignment string' do
        expect(subject.options).to eq(
          ['includeOptional=customFields,nullCustomFields']
        )
      end
    end

    describe '#options=' do
      it 'should take a list' do
        subject.options = %w/customFields nullCustomFields/
        expect(subject.options).to eq(
          ['includeOptional=customFields,nullCustomFields']
        )
      end
    end

    describe '#arguments' do
      let(:fields) do
        %w/
          orderId=1
        /
      end

      let(:args) do
        %w/
          firstResult=1
          pageSize=100
          includeOptional=customFields,nullCustomFields
        /.sort
      end

      it 'should return an arguments hash' do
        expect(subject.arguments).to eq(fields + args)
      end
    end

    describe '#to_s' do
      let(:test_url) do
        '%s?%s=1&%s' % [search_url, id_field, default_search_options]
      end

      it 'should return the correct URL' do
        expect(subject.to_s).to eq(test_url)
      end
    end
  end

  context 'with invalid params' do
    let(:params) { invalid_params }

    it 'should use valid default pagination options' do
      expect(subject.pagination).to eq(['firstResult=1', 'pageSize=500'])
    end

    it 'should raise an error when the fields are missing' do
      pending 'This class should have validations'
    end
  end
end
