require 'spec_helper'

describe Nacre::OrderSearchResults do

  describe 'initialization' do

    let(:results_hash) { fixture_file_content('order_search_result.json') }

    context 'with valid JSON data' do
      let(:results) do
        Nacre::OrderSearchResults.new(JSON.parse(results_hash)['response'])
      end

      it_should_behave_like 'Enumerable' do
        let(:subject) { results }
      end

      it 'should return an OrderSearchResults instance' do
        expect(results).to be_a(Nacre::OrderSearchResults)
      end
    end

    context 'with invalid data' do
      it 'should raise an error' do
        expect { Nacre::OrderSearchResults.from_json('') }
          .to raise_error(Nacre::OrderSearchResultsError)
      end
    end
  end

  describe '.from_json' do

    let(:results_hash) { fixture_file_content('order_search_result.json') }

    context 'with valid JSON data' do
      let(:results) { Nacre::OrderSearchResults.from_json(results_hash) }

      it 'should return an OrderSearchResults instance' do
        expect(results).to be_a(Nacre::OrderSearchResults)
      end
    end

    context 'with invalid data' do
      it 'should raise an error' do
        expect { Nacre::OrderSearchResults.from_json('') }
          .to raise_error(Nacre::OrderSearchResultsError)
      end
    end
  end

  describe '#orders' do
    let(:json) { fixture_file_content('order_search_result.json') }

    let(:results) { Nacre::OrderSearchResults.from_json(json) }

    it 'should return a list of order params' do
      expect(results.orders).to respond_to(:each)
      expect(results.orders.first).to be_a(Hash)
      expect(results.orders.first[:order_id]).to eql('123456')
    end
  end
end
