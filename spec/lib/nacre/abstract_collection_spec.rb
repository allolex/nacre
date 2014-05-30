require 'spec_helper'

describe Nacre::AbstractCollection do

  it_should_behave_like 'Resourceable' do
    let(:params) do
      {
        foo: 'bar'
      }
    end
  end
end
