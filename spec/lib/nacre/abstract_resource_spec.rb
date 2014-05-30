require 'spec_helper'

describe Nacre::AbstractResource do

  describe 'initialization' do
    it 'should create attributes from the params' do
      pending
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
    it 'should create an accessor' do
      pending
    end

    it 'should add the attribute to the fields list' do
      pending
    end
  end

  describe '.fields' do
    it 'should be a list of attribute symbols' do
      pending
    end
  end

  describe '#attributes=' do
    it 'should set the attributes only for existing fields' do
      pending
    end

    it 'should ignore attributes for non-existent fields' do
      pending
    end
  end

  describe '.from_json' do
    context "when it's a real response" do
      it 'returns a new object with the params from json' do
        pending
      end
    end

    context "when it's an error (outside of a response structure)" do
      it 'adds the unstructured error to the connection errors' do
        pending
      end
    end
  end

  describe '.errors' do
    it 'returns the errors from the connection' do
      pending
    end
  end
end
