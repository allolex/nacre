require 'spec_helper'

describe Nacre::SearchResults do

  let(:params) do
    {
       reference: {
          order_status_names: {
             '4' => 'Invoiced'
          },
          order_stock_status_names: {
             '3' => 'All fulfilled'
          },
          order_type_names: {
             '1' => 'SALES_ORDER'
          }
       },
       response: {
          meta_data: {
             sorting: [
                {
                   direction: 'ASC',
                   filterable: {
                      required: false,
                      report_data_type: 'INTEGER',
                      name: 'orderId',
                      sortable: true,
                      filterable: true
                   }
                }
             ],
             columns: [
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderTypeNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderTypeId',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'contactId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderStatusNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderStatusId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderStockStatusNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderStockStatusId',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'PERIOD',
                   name: 'createdOn',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'createdById',
                   sortable: true,
                   filterable: true
                }
             ],
             last_result: 3,
             first_result: 1,
             results_returned: 3,
             results_available: 3
          },
          results: [
             [
                123456,
                1,
                253,
                4,
                3,
                '2012-12-13T13:00:42.000Z',
                280
             ],
             [
                123457,
                1,
                253,
                4,
                3,
                '2012-12-14T13:00:42.000Z',
                280
             ],
             [
                123458,
                1,
                253,
                4,
                3,
                '2012-12-14T14:00:42.000Z',
                280
             ]
          ]
       }
    }
  end

  subject { Nacre::SearchResults.new(params) }

  describe 'initialization' do

    context 'with parameters' do
      it_should_behave_like 'Enumerable'

      it 'should return an SearchResults instance' do
        expect(subject).to be_a(Nacre::SearchResults)
      end
    end

    context 'with empty parameters' do
      subject { Nacre::SearchResults.new }

      it 'should return an SearchResults instance' do
        expect(subject).to be_a(Nacre::SearchResults)
      end
    end
  end

  describe '.from_json' do
    context 'with valid JSON data' do
      let(:json) { fixture_file_content('order_search_result.json') }

      subject { Nacre::SearchResults.from_json(json) }

      it 'should return an SearchResults instance' do
        expect(subject).to be_a(Nacre::SearchResults)
      end
    end

    context 'with invalid data' do
      it 'should raise an error' do
        expect { Nacre::SearchResults.from_json('') }
          .to raise_error(Nacre::SearchResultsError)
      end
    end
  end

  describe '#results' do
    let(:json) { fixture_file_content('order_search_result.json') }

    subject { Nacre::SearchResults.from_json(json) }

    it 'should return a list of order params' do
      expect(subject.results.first).to be_a(Hash)
      expect(subject.results.first[:order_id]).to eql('123456')
    end
  end

  describe '#columns' do
    it 'should return a list of column properties' do
      expect(subject.columns.first).to be_a(Nacre::ColumnProperty)
    end
  end

  describe '#total_results' do
    it 'should be the correct value' do
      expect(subject.total_results).to eq(3)
    end
  end

  describe '#returned_results' do
    it 'should be the correct value' do
      expect(subject.returned_results).to eq(3)
    end
  end

  describe '#first_result' do
    it 'should be the correct value' do
      expect(subject.first_result).to eq(1)
    end
  end

  describe '#last_result' do
    it 'should be the correct value' do
      expect(subject.last_result).to eq(3)
    end
  end
end
