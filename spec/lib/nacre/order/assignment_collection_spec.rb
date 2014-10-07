require 'spec_helper'

describe Nacre::Order::AssignmentCollection do
  let(:params) do
    {
      current: {
        channel_id: 4,
        project_id: 0,
        lead_source_id: 3,
        staff_owner_contact_id: 208,
        team_id: 0
      }
    }
  end

  subject { described_class.new(params) }

  it_behaves_like 'Enumerable'

  it_behaves_like 'Parametrizable'

  it 'should be a collection of Order::AssignmentDetails' do
    expect(subject.first).to be_a(Nacre::Order::Assignment)
  end

  describe '#current' do
    it 'should returnt the current assignment' do
      expect(subject.current.key).to eq(:current)
    end
  end
end
