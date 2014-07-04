require 'spec_helper'

describe Factor do
  it 'should update influnce on create' do
    org = create(:organisation)
    user = create(:user, organisation: org)
    project = create(:project, organisation: org, user: user)
    idea = create(:idea, project: project, user: user)
    create(:factor)
    expect(idea.influences.count).to eq(1)
  end
end
