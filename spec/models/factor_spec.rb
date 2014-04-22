require 'spec_helper'

describe Factor do
  it "should update influnce on create" do
    org = FactoryGirl.create(:organisation)
    user = FactoryGirl.create(:user, organisation: org)
    project = FactoryGirl.create(:project, organisation: org, user: user)
    idea = FactoryGirl.create(:idea, project: project, user: user)
    FactoryGirl.create(:factor)
    expect(idea.influences.count).to eq(1)
  end
end
