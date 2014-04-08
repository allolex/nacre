require 'spec_helper'

describe Nacre::Product::SalesChannel do

  let(:params) do
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
  end

  subject { Nacre::Product::SalesChannel.new(params) }

  it 'should have a name' do
    expect(subject.sales_channel_name).to eql('Brightpearl')
  end

  it 'should have a product name' do
    expect(subject.product_name).to eql('Product B')
  end

  it 'should have a product condition' do
    expect(subject.product_condition).to eql('new')
  end

  it 'should have categories' do
    expect(subject.categories).to be_a(Array)
  end

  it 'should have a description' do
    expect(subject.description).to be_a(Nacre::Product::Description)
  end

  it 'should have a short description' do
    expect(subject.short_description).to be_a(Nacre::Product::Description)
  end

  it_should_behave_like 'Parametrizable'
end
