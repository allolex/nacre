require 'spec_helper'

describe Nacre::SearchResultsCollection do
  let!(:link) { Nacre::Connection.new }

  def fix_results(first,last,returned,available)
    results = search_results_test_params
    metadata = results[:response][:meta_data]
    metadata[:first_result] = first
    metadata[:last_result] = last
    metadata[:results_returned] = returned
    metadata[:results_available] = available
    results
  end

  let(:first_result) { fix_results(1,3,3,12) }
  let(:second_result) { fix_results(4,6,3,12) }
  let(:third_result) { fix_results(7,9,3,12) }
  let(:fourth_result) { fix_results(10,12,3,12) }

  let(:full_params) do
    [
      first_result,
      second_result,
      third_result,
      fourth_result
    ]
  end

  let(:params) { full_params }

  let(:initial_options) do
    {
      search_url: order_search_url,
      fields: {
        order_id: 1
      },
      pagination: {
        first_record: 1,
        window: 3
      },
      options: [
        'customFields',
        'nullCustomFields'
      ]
    }
  end

  subject { described_class.new(params: params, options: initial_options) }

  it_should_behave_like 'Enumerable'

  describe '#members' do
    it 'should be a list' do
      expect(subject.members).to be_a(Array)
    end

    it 'each item should respond to #results' do
      expect(subject.members.first).to respond_to(:results)
    end
  end

  describe '#each' do

    it 'should return each individual result from its members' do
      count = 0
      subject.each do |result|
        count += 1
      end
      expect(count).to eq(12)
    end

    context 'when it reaches the last result from its members' do
      let(:params) { [first_result] }

      let(:resource_endpoint) { order_search_url }

      let(:search_options) do
        opts = initial_options
        opts[:pagination][:first_record] = 4
        opts[:pagination][:window] = 3
      end

      let(:range) { 1 }

      subject do
        described_class.new(
          params: params,
          options: initial_options
        )
      end

      before do
        @url = Nacre::RequestUrl.new(
          initial_options
        )
        @url.pagination = { first_record: 4, window: 3 }
        stub_request(
          :get,
          @url.to_s
        ).to_return(
          status: 200,
          body: fixture_file_content('order_next_search_result.json'),
          headers: {}
        )
      end

      context 'and there are more results on the server' do

        before do
          stub_request(:get, "#{resource_endpoint}/#{range}?#{search_options}")
          @results = subject.first(5)
        end

        it 'should request more results from the server' do
          expect(a_request(:get, @url.to_s)).to have_been_made
        end

        it 'should have five results' do
          expect(@results.count).to eq(5)
        end
      end

      context 'and there are no more results on the server' do

        subject { described_class.new(params: full_params, options: initial_options) }

        let!(:results) { subject.first(13) }

        it 'should not make a further request for results to the server' do
          expect(a_request(:get, @url.to_s)).to_not have_been_made
        end

        it 'should return 12 results' do
          expect(results.count).to eq(12)
        end
      end
    end
  end

  describe '#each_page' do
    it 'should return each page of results from its members' do

    end
  end

  describe '#first' do
    it 'should return the first result' do

    end

    it 'should return two results with #first(2)' do

    end
  end

end
