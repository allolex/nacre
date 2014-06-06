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
        window: 500
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

    describe '#ids' do
      context 'when given a single id string' do
        it 'should return a single id string' do
          ids = '1'
          subject.ids = ids
          expect(subject.ids).to eq(ids)
        end
      end

      context 'when given a single id list' do
        it 'should return a single id string' do
          ids = [1]
          subject.ids = ids
          expect(subject.ids).to eq(ids.first.to_s)
        end
      end
      context 'when given a range of ids' do
        it 'should return an id range string' do
          ids = '1-5'
          subject.ids = ids
          expect(subject.ids).to eq('1-5')
        end
      end

      context 'when given a single id' do
        it 'should return an id list string' do
          ids = %w/1 2 3 4 5/
          subject.ids = ids
          expect(subject.ids).to eq('1,2,3,4,5')
        end
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
          ['firstResult=1','pageSize=500']
        )
      end
    end

    describe '#pagination_params' do
      it 'should return a hash of pagination options' do
        expect(subject.pagination_params).to eq(
          { first_record: 1, window: 500 }
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
          pageSize=500
          includeOptional=customFields,nullCustomFields
        /.sort
      end

      it 'should return an arguments hash' do
        expect(subject.arguments).to eq(fields + args)
      end
    end

    describe '#to_s' do
      context 'with no range provided' do
        let(:url) do
          '%s?%s=1&%s' % [search_url, id_field, default_search_options]
        end

        it 'should return the correct URL' do
          expect(subject.to_s).to eq(url)
        end
      end

      context 'with a range provided' do

        let(:range) { '1-3' }

        let(:params) do
          {
            search_url: order_service_url,
            ids: range,
            options: [
              'customFields',
              'nullCustomFields'
            ]
          }
        end

        let(:url) do
          '%s/%s?%s' % [order_service_url, range, default_get_options]
        end

        it 'should have no pagination options' do
          expect(subject.pagination).to eq('')
        end

        it 'should return the correct URL' do
          expect(subject.to_s).to eq(url)
        end
      end

    end
  end

  context 'with invalid params' do
    let(:params) { invalid_params }

    it 'should use valid default pagination options' do
      expect(subject.pagination).to eq(['firstResult=1', 'pageSize=500'])
    end

    xit 'should raise an error when the fields are missing' do
    end
  end
end
