require 'spec_helper'

describe Nacre::AbstractCollection do

  it_behaves_like 'Resourceable' do
    let(:params) do
      {
        foo: 'bar'
      }
    end
  end
end
