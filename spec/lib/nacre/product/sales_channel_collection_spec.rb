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

  describe '#product_name' do

    let(:params_with_two_channels) do
      [
        {
          sales_channel_name: "Brightpearl",
          product_name: "Product B",
          product_condition: "new",
          categories: [],
          description: {},
          short_description: {}
        },
        {
          sales_channel_name: "Reseller A",
          product_name: "Product Reseller Lemon",
          product_condition: "new",
          categories: [],
          description: {},
          short_description: {}
        }
      ]
    end

    subject { Nacre::Product::SalesChannelCollection.new(params) }

    context 'with a Brighpearl channel' do
      let(:params) { params_with_two_channels }

      it 'should return the name from the Brightpearl challenge' do
        expect(subject.product_name).to eq('Product B')
      end
    end

    context 'with no Brightpearl channel' do
      let(:params) { [ params_with_two_channels.last ] }

      it 'should return nil' do
        expect(subject.product_name).to be_nil
      end
    end


    context 'with complex parameters' do
      let(:params) do
        [
          {
            product_name:  "An Artist - A Title EP",
            short_description:  {
              language_code:  "en",
              format:  "HTML_FRAGMENT",
              text:  "Music release"
            },
            sales_channel_name:  "Brightpearl",
            product_condition:  "new",
            categories:  [
              {
              category_code:  "297"
              }
            ],
            description:  {
              language_code:  "en",
              format:  "HTML_FRAGMENT",
              text:  "Some music release text"
            }
          }
        ]
      end

      subject { Nacre::Product::SalesChannelCollection.new(params) }

      it 'should have a product name' do
        expect(subject.product_name).to eq('An Artist - A Title EP')
      end
    end
  end

  it_should_behave_like 'Parametrizable'
end
