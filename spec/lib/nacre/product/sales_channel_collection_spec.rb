require 'spec_helper'

describe Nacre::Product::SalesChannelCollection do
  let(:params) do
    [
      {
        sales_channel_name: "Brightpearl",
        product_name: "Product B",
        product_condition: "new",
        categories: [
          { category_code: "276" },
          { category_code: "295" }
        ],
        description: {
          language_code: "en",
          text: "<p>Some description</p>",
          format: "HTML_FRAGMENT"
        },
        short_description: {
          language_code: "en",
          text: "<p>Some short description</p>",
          format: "HTML_FRAGMENT"
        }
      }
    ]
  end

  subject { Nacre::Product::SalesChannelCollection.new(params) }

  it_should_behave_like 'Enumerable'

  describe 'members' do
    it 'should contain SalesChannel instances' do
      expect(subject.first).to be_a(Nacre::Product::SalesChannel)
    end
  end

  it_should_behave_like 'Parametrizable'

end
