require 'spec_helper'

describe Nacre::AbstractCollection do

  let(:params) do
    {
      foo: 'bar'
    }
  end

  class FailingTestClass < Nacre::AbstractCollection; end

  describe '#resource_class' do
    context 'when not defined' do
      it 'should raise an exception' do
        expect { FailingTestClass.new(params) }.to raise_error(NotImplementedError)
      end

      it 'should provide a useful error message' do
        expect { FailingTestClass.new(params) }.to raise_error(
          NotImplementedError,
          'Including object must implement private #resource_class'
        )
      end
    end
  end
end
