require "spec_helper"

describe Nacre::Channel do

  let!(:link) { Nacre::Connection.new }

  let(:params) do
    {
      id: 1,
      name: 2,
      channel_type_id: 3,
      default_warehouse_id: 4,
      contact_group_id: 5,
      default_price_list_id: 6,
      channel_brand_id: 7,
      warehouse_ids: [ 8, 9, 10 ]
    }
  end

  subject { described_class.new(params) }

  it_behaves_like "Parametrizable"

  context "initialization" do

    describe ".new" do
      it "should have an id" do
        expect(subject.id).to eq params[:id]
      end
    end

    describe ".from_json" do
      let(:json) { fixture_file_content("channel.json") }

      subject { described_class.from_json(json) }

      it "has the correct id" do
        expect(subject.id).to eq 3
      end

      it "has the correct name" do
        expect(subject.name).to eq "Good name"
      end

      it "has the correct channel type ID" do
        expect(subject.channel_type_id).to eq 2
      end

      it "has the correct default warehouse ID" do
        expect(subject.default_warehouse_id).to eq 4
      end

      it "has the correct contact group ID" do
        expect(subject.contact_group_id).to eq 5
      end

      it "has the correct default price list ID" do
        expect(subject.default_price_list_id).to eq 6
      end

      it "has the correct channel brand ID" do
        expect(subject.channel_brand_id).to eq 7
      end

      it "has the correct warehouse IDs" do
        expect(subject.warehouse_ids).to eq [ 30, 40, 50 ]
      end
    end
  end

  context "API interactions" do
    let!(:link) { Nacre::Connection.new }

    let(:resource) { "product" }

    let(:api_details) do
      [
        Nacre.configuration.api_version,
        Nacre.configuration.user_id
      ]
    end

    describe ".get" do
      let(:resource_endpoint) {
        channel_service_url
      }

      let(:range) { 3 }

      it "should make a request to the correct endpoint" do
        stub_request(:get, "#{resource_endpoint}/#{range}").
          to_return(
            status:  200,
            body:  fixture_file_content("channel.json"),
            headers:  {}
          )

        channel = described_class.get(3)

        expect(a_request(
          :get,
          "#{resource_endpoint}/#{range}"
        )).to have_been_made

        expect(channel.id).to eql(3)
      end
    end
  end
end
