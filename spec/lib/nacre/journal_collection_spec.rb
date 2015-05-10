require "spec_helper"

describe Nacre::JournalCollection do

  let!(:link) { Nacre::Connection.new }

  let(:parametrized_list) do
    [
      {
        id: 1,
        journal_type_id: "PP",
        description: "Cool"
      },
      {
        id: 2,
        journal_type_id: "SR",
        description: "Cooler"
      },
    ]
  end

  let(:subject) { described_class.new(parametrized_list) }

  it_behaves_like "Enumerable"

  context "initialization" do
    describe ".new" do
      it "should create a list of Journals" do
        expect(subject.first).to be_a(Nacre::Journal)
      end
    end

    describe ".from_json" do
      let(:json) { fixture_file_content("journal_collection.json") }
      let(:subject) { described_class.from_json(json) }

      it "should be a list of Journals" do
        expect(subject.first).to be_a(Nacre::Journal)
      end
    end
  end

  describe ".get" do
    let(:range) { "10000-10010" }

    let(:get_options) do
      {
        search_url: journal_service_url,
        ids: range
      }
    end

    before do
      @url = Nacre::RequestUrl.new(get_options)
      stub_request(
        :get,
        @url.to_s
      ).to_return(
        status: 200,
        body: fixture_file_content("journal_collection.json"),
        headers: {}
      )
      @collection = Nacre::JournalCollection.get(range)
    end

    it "should query the API server" do
      expect(a_request(:get, @url.to_s)).to have_been_made
    end

    it "should return a valid JournalCollection" do
      expect(@collection).to be_a(Nacre::JournalCollection)
    end

    it "should contain the fixture journals" do
      expect(@collection.first).to be_a(Nacre::Journal)
    end
  end
end
