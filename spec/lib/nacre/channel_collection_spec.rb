require "spec_helper"

describe Nacre::ChannelCollection do

  let!(:link) { Nacre::Connection.new }

  let(:parametrized_list) do
    [
      {
        id: 1,
        name: "Department 1",
        channel_type_id: 3,
        channel_brand_id: 4
      },
      {
        id: 2,
        name: "Channel Post Duplicate",
        channel_type_id: 5,
        channel_brand_id: 6
      }
    ]
  end

  let(:subject) { described_class.new(parametrized_list) }

  it_behaves_like "Enumerable"

  context "initialization" do
    describe ".new" do
      it "should create a list of Channels" do
        expect(subject.first).to be_a(Nacre::Channel)
      end
    end

    describe ".from_json" do
      let(:json) { fixture_file_content("channel_collection.json") }
      let(:subject) { described_class.from_json(json) }

      it "should be a list of Channels" do
        expect(subject.first).to be_a(Nacre::Channel)
      end
    end
  end

  describe ".get" do
    let(:range) { "1-3" }

    let(:get_options) do
      {
        search_url: channel_service_url,
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
        body: fixture_file_content("channel_collection.json"),
        headers: {}
      )
      @collection = Nacre::ChannelCollection.get(range)
    end

    it "should query the API server" do
      expect(a_request(:get, @url.to_s)).to have_been_made
    end

    it "should return a valid ChannelCollection" do
      expect(@collection).to be_a(Nacre::ChannelCollection)
    end

    it "should contain the fixture channels" do
      expect(@collection.first).to be_a(Nacre::Channel)
    end
  end
end
