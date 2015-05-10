require "spec_helper"

describe Nacre::Product::Description do
  let(:params) do
    {
      language_code: "en",
      text: "<p>Some description</p>",
      format: "HTML_FRAGMENT"
    }
  end

  subject { Nacre::Product::Description.new(params) }

  it "should have a language code" do
    expect(subject.language_code).to eql(params[:language_code])
  end

  it "should have a text" do
    expect(subject.text).to eql(params[:text])
  end

  it "should have a format" do
    expect(subject.format).to eql(params[:format])
  end

  it_behaves_like "Parametrizable"
end
