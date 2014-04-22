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

  it_should_behave_like 'Enumerable'

  it_should_behave_like 'Parametrizable'

  it 'should be a collection of Order::AssignmentDetails' do
    expect(subject.first).to be_a(Nacre::Order::Assignment)
  end
end
