require "spec_helper"

describe Nacre::NominalCodeCollection do

  let!(:link) { Nacre::Connection.new }

  let(:parametrized_list) do
    [
      {
        id: 1,
        name: "First Code",
        code: "1000"
      },
      {
        id: 2,
        name: "Second Code",
        code: "2000"
      }
    ]
  end

  let(:subject) { described_class.new(parametrized_list) }

  it_behaves_like "Enumerable"

  context "initialization" do
    describe ".new" do
      it "should create a list of NominalCodes" do
        expect(subject.first).to be_a(Nacre::NominalCode)
      end
    end

    describe ".from_json" do
      let(:json) { fixture_file_content("nominal_code_collection.json") }
      let(:subject) { described_class.from_json(json) }

      it "should be a list of NominalCodes" do
        expect(subject.first).to be_a(Nacre::NominalCode)
      end
    end
  end

  describe ".get" do
    let(:range) { "1-3" }

    let(:get_options) do
      {
        search_url: nominal_code_service_url,
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
        body: fixture_file_content("nominal_code_collection.json"),
        headers: {}
      )
      @collection = Nacre::NominalCodeCollection.get(range)
    end

    it "should query the API server" do
      expect(a_request(:get, @url.to_s)).to have_been_made
    end

    it "should return a valid NominalCodeCollection" do
      expect(@collection).to be_a(Nacre::NominalCodeCollection)
    end

    it "should contain the fixture nominal_codes" do
      expect(@collection.first).to be_a(Nacre::NominalCode)
    end
  end
end
