require "spec_helper"

describe Nacre::Journal do

  let!(:link) { Nacre::Connection.new }

  let(:params) do
    {
      id: 5,
      journal_type_code: "SR",
      due_date: "2015-01-01T00:00:00.000Z"
    }
  end

  describe "initialization" do

    context "with simple params" do
      subject { described_class.new(params) }

      it "has an id" do
        expect(subject.id).to eql(5)
      end

      it "has a journal type code" do
        expect(subject.journal_type_code).to eql("SR")
      end

      it "has a due_date" do
        expect(subject.due_date).to eq "2015-01-01T00:00:00.000Z"
      end
    end

    context "with complex params" do
      let(:fixture_file_name) { "journal_get_one.json" }

      subject do
        described_class.from_json(
          fixture_file_content(fixture_file_name)
        )
      end

      it "has an id" do
        expect(subject.id).to eq(1000)
      end

      it "has a contact_id" do
        expect(subject.contact_id).to eq(100)
      end

      it "has a journal_type_code" do
        expect(subject.journal_type_code).to eq("PP")
      end

      it "has a tax_date" do
        expect(subject.tax_date).to eq "2015-01-01T00:00:00.000Z"
      end

      it "has a created_on date" do
        expect(subject.created_on).to eq "2015-01-01T00:00:00.000Z"
      end

      it "has a created_by_contact_id" do
        expect(subject.created_by_contact_id).to eq 210
      end

      it "has a tax_reconciliation hash" do
        expect(subject.tax_reconciliation).to respond_to :keys
      end

      it "has a credits list" do
        expect(subject.credits).to respond_to :<<
      end

      it "has a debits list" do
        expect(subject.debits).to respond_to :<<
      end

      it "has a journal_type_code" do
        expect(subject.journal_type_code).to eq("PP")
      end
    end
  end

  describe ".from_json" do

    let(:json) { fixture_file_content("journal_get_one.json") }

    subject { described_class.from_json(json) }

    it "should have an id" do
      expect(subject.id).to eql(1000)
    end

    it "should have a description" do
      expect(subject.description).to eql("12345")
    end
  end

  describe "#params" do

    context "with all the valid params" do
      let(:valid_params) {
        {
          id:  "3",
          contact_id:  "9999",
          created_on:  "2014-05-20T00:00:00.000+01:00",
          created_by_contact_id:  "100",
        }
      }

      let(:order) { Nacre::Journal.new(valid_params) }

      it "should output a hash identical to the input hash" do
        expect(order.params).to eql(valid_params)
      end
    end
  end

  describe ".get" do
    let(:resource_endpoint) { journal_service_url }
    let(:range) { 1000 }
    let(:url) { "#{resource_endpoint}/#{range}?includeOptional=customFields,nullCustomFields" }
    let(:fixture_file_name) { "journal_get_one.json" }

    it "should make a request to the correct endpoint" do
      stub = stub_request(:get, "#{resource_endpoint}/#{range}").
        to_return(
          status:  200,
          body:  fixture_file_content(fixture_file_name),
          headers:  {}
        )
      resource = described_class.get(range)
      expect(stub).to have_been_requested
      expect(resource.id).to eql(range)
    end
  end

  describe ".find" do
    context "by ID" do
      let(:id_text) { "1" }

      subject { described_class.find(id_text) }

      before do
        stub_request(
          :get,
          "#{journal_search_url}?%s" % [default_search_options(["journalId=#{id_text}"])]
        ).to_return(
          status: 200,
          body: fixture_file_content("journal_search_result.json"),
          headers: {}
        )
      end

      it "should return search results" do
        expect(subject).to be_a(Nacre::SearchResultsCollection)
      end

      it "should find an order with the correct ID" do
        expect(subject.first[:journal_id]).to eql(id_text.to_s)
      end
    end
  end
end
