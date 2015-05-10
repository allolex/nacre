require "spec_helper"

describe Nacre::Product::StockDetails do
  let(:params) do
    {
      stock_tracked: true
    }
  end

  subject { Nacre::Product::StockDetails.new(params) }

  describe "#stock_tracked" do
    context "when 'true'" do
      it "should have a boolean value of TRUE for stock_tracked" do
        expect(subject.stock_tracked).to eql(true)
      end
    end

    context "given not 'true' values" do
      %w/false 12 truthy/.each do |test_value|

        let!(:params) do
          { stock_tracked: test_value }
        end

        it "'#{test_value}' should return false" do
          expect(subject.stock_tracked).to eql(false)
        end
      end
    end
  end

  it_behaves_like "Parametrizable"
end
