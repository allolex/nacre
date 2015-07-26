
require "spec_helper"

describe Nacre::NominalCode do

  let!(:link) { Nacre::Connection.new }

  let(:params) do
    {
      id: 1,
      code: "0010",
      name: "Freehold Property",
      type: {
        id: 1
      },
      bank: false,
      expense: false,
      discount: false,
      editable: true,
      active: true,
      tax_code: 0,
      description: "",
      chart_map_code: "",
      reconcile: false
    }
  end

  subject { described_class.new(params) }

  it_behaves_like "Parametrizable"

  context "initialization" do

    describe ".new" do
      it "should have an id" do
        expect(subject.id).to eq params[:id]
      end

      it "should have a name" do
        expect(subject.name).to eq params[:name]
      end
    end

    describe ".from_json" do
      let(:json) { fixture_file_content("nominal_code.json") }

      subject { described_class.from_json(json) }

      it "has the correct id" do
        expect(subject.id).to eq 1
      end

      it "has the correct name" do
        expect(subject.name).to eq "Freehold Property"
      end

      it "has the correct code" do
        expect(subject.code).to eq "0010"
      end

      it "has the correct bank value" do
        expect(subject.bank).to eq false
      end

      it "has the correct tax code" do
        expect(subject.tax_code).to eq 0
      end

      it "has the correct default price list ID" do
        expect(subject.chart_map_code).to eq ""
      end
    end
  end

  context "API interactions" do
    let!(:link) { Nacre::Connection.new }

    let(:resource) { "accounting" }

    let(:api_details) do
      [
        Nacre.configuration.api_version,
        Nacre.configuration.user_id
      ]
    end

    describe ".get" do
      let(:resource_endpoint) {
        nominal_code_service_url
      }

      let(:range) { 1 }

      it "should make a request to the correct endpoint" do
        stub_request(:get, "#{resource_endpoint}/#{range}").
          to_return(
            status:  200,
            body:  fixture_file_content("nominal_code.json"),
            headers:  {}
          )

        nominal_code = described_class.get(range)

        expect(a_request(
          :get,
          "#{resource_endpoint}/#{range}"
        )).to have_been_made

        expect(nominal_code.id).to eql(range)
      end
    end
  end
end
