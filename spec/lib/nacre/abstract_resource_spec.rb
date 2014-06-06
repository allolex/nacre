require 'spec_helper'

describe Nacre::AbstractResource do

  describe 'initialization' do
    xit 'should create attributes from the params' do
    end
  end

  it_should_behave_like 'Resourceable' do
    let(:params) do
      {
        foo: 'bar'
      }
    end
  end

  describe '.attribute' do
    xit 'should create an accessor' do
    end

    xit 'should add the attribute to the fields list' do
    end
  end

  describe '.fields' do
    xit 'should be a list of attribute symbols' do
    end
  end

  describe '#attributes=' do
    xit 'should set the attributes only for existing fields' do
    end

    xit 'should ignore attributes for non-existent fields' do
    end
  end

  describe '.from_json' do
    context "when it's a real response" do
      xit 'returns a new object with the params from json' do
      end
    end

    context "when it's an error (outside of a response structure)" do
      xit 'adds the unstructured error to the connection errors' do
      end
    end
  end

  describe '.errors' do
    xit 'returns the errors from the connection' do
    end
  end
end
