require 'spec_helper'

describe Factor do
  it 'should update influnce on create' do
    org = create(:organisation)
    user = create(:user, organisation: org)
    project = create(:project, organisation: org, user: user)
    idea = create(:idea, project: project, user: user)
    create(:factor, project: project)
    expect(idea.influences.count).to eq(1)
  end

  it 'should require a name' do
    org = create(:organisation)
    user = create(:user, organisation: org)
    project = create(:project, organisation: org, user: user)
    factor = Factor.new(project: project)
    expect(factor).not_to be_valid
  end

  it 'should require a project' do
    factor = Factor.new(name: 'test')
    expect(factor).not_to be_valid
  end
end
