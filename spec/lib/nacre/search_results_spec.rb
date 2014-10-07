require 'spec_helper'

describe Nacre::SearchResults do

  let(:params) do
    search_results_test_params
  end

  subject { Nacre::SearchResults.new(params) }

  describe 'initialization' do

    context 'with parameters' do
      it_behaves_like 'Enumerable'

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
