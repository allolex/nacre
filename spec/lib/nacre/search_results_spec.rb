require 'spec_helper'

describe Nacre::SearchResults do

  describe 'initialization' do

    let(:results_hash) { fixture_file_content('order_search_result.json') }

    context 'with valid JSON data' do
      let(:results) do
        Nacre::SearchResults.new(JSON.parse(results_hash)['response'])
      end

      it_should_behave_like 'Enumerable' do
        let(:subject) { results }
      end

      it 'should return an SearchResults instance' do
        expect(results).to be_a(Nacre::SearchResults)
      end
    end

    context 'with invalid data' do
      it 'should raise an error' do
        expect { Nacre::SearchResults.from_json('') }
          .to raise_error(Nacre::SearchResultsError)
      end
    end
  end

  describe '.from_json' do

    let(:results_hash) { fixture_file_content('order_search_result.json') }

    context 'with valid JSON data' do
      let(:results) { Nacre::SearchResults.from_json(results_hash) }

      it 'should return an SearchResults instance' do
        expect(results).to be_a(Nacre::SearchResults)
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

    let(:search) { Nacre::SearchResults.from_json(json) }

    it 'should return a list of order params' do
      expect(search.results).to respond_to(:each)
      expect(search.results.first).to be_a(Hash)
      expect(search.results.first[:order_id]).to eql('123456')
    end
  end
end
