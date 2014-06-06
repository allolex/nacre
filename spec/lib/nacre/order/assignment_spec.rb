require 'spec_helper'

describe Nacre::Order::Assignment do
  let(:params) do
    {
      channel_id: 4,
      project_id: 0,
      lead_source_id: 3,
      staff_owner_contact_id: 208,
      team_id: 0
    }
  end

  subject { described_class.new('current', params) }

  it 'should have an assignment key' do
    expect(subject.key).to eq('current')
  end

  it 'should have a channel ID' do
    expect(subject.channel_id).to eq(4)
  end

  it 'should have a project ID' do
    expect(subject.project_id).to eq(0)
  end

  it 'should have a lead source ID' do
    expect(subject.lead_source_id).to eq(3)
  end

  it 'should have a staff owner contact ID' do
    expect(subject.staff_owner_contact_id).to eq(208)
  end

  it 'should have a team ID' do
    expect(subject.team_id).to eq(0)
  end
end
