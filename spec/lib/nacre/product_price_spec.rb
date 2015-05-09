require "spec_helper"

describe Nacre::ProductPrice do
  let!(:link) { Nacre::Connection.new }

  let(:params) do
    {
      product_id: 1010,
      price_lists: [
        {
          price_list_id: 0,
          currency_code: "GBP",
          quantity_price: {
            "1" => "10",
            "5" => "9.555",
            "15" => "9",
            "25" => "8",
            "50" => "7.5",
            "200" => "7"
          }
        },
        {
          price_list_id: 1,
          currency_code: "GBP",
          quantity_price: {
            "1" => "12",
            "100" => "11",
            "1000" => "10",
            "5000" => "9.5"
          }
        },
        {
          price_list_id: 2,
          currency_code: "GBP",
          quantity_price: {
            "1" => "12.5000",
            "5" => "12.3333",
            "25" => "11.6667",
            "50" => "12.3333",
            "150" => "11.6667",
            "250" => "10.8333"
          }
        }
      ]
    }
  end

  subject { described_class.new(params) }

  describe "#product_id" do
    it "should have the correct value" do
      expect(subject.product_id).to eq(1010)
    end
  end

  describe "#price_lists" do
    it "should be a price list collection" do
      expect(subject.price_lists).to be_a(Nacre::PriceListCollection)
    end
  end

  describe ".get" do
    let(:resource_endpoint) do
      price_list_service_url
    end

    let(:url) { "#{resource_endpoint}/#{range}" }

    def make_resource_request(url, fixture_file_name)
      stub_request(:get, url).
        to_return(
          status:  200,
          body:  fixture_file_content(fixture_file_name),
          headers:  {}
        )
      described_class.get(range)
    end

    context "when the price list exists" do
      let(:fixture_file_name) { "price_list.json" }
      let(:range) { 1010 }

      it "should make a request to the correct endpoint" do
        make_resource_request(url, fixture_file_name)
        expect(a_request(:get, url)).to have_been_made
      end

      it "should return a price list collection" do
        resource = make_resource_request(url, fixture_file_name)
        expect(resource).to be_a(Nacre::ProductPrice)
      end
    end

    context "when the price list does not exist" do
      let(:fixture_file_name) { "price_list_not_found.json" }
      let(:range) { 999999 }

      it "should make a request to the correct endpoint" do
        make_resource_request(url, fixture_file_name)
        expect(a_request(:get, url)).to have_been_made
      end

      it "should return nil" do
        resource = make_resource_request(url, fixture_file_name)
        expect(resource).to be_nil
      end

      it "should have errors in the last request" do
        make_resource_request(url, fixture_file_name)
        expect(described_class.errors.count).to eq(1)
      end

      it "should have the correct error message" do
        make_resource_request(url, fixture_file_name)
        message = described_class.errors.first[:message]
        expect(message).to match(/No Price Lists Found/)
      end
    end
  end

  describe ".errors" do
    context "when there are errors" do
      xit "should return a list of errors" do
      end
    end

    context "when there are no errors" do
      xit "should return an empty list" do
      end
    end
  end
end
