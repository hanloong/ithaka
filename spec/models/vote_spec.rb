require 'spec_helper'

describe Vote do
  before :each do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    idea = FactoryGirl.create(:idea, project: project, user: user)
    @attr = {
      idea: idea,
      user: user
    }
  end

  it 'should create a valid vote' do
    vote = Vote.new(@attr)
    expect(vote).to be_valid
  end

  it 'should require an idea' do
    @attr[:idea] = nil
    vote = Vote.new(@attr)
    expect(vote).not_to be_valid
  end

  it 'should require an user' do
    @attr[:user] = nil
    vote = Vote.new(@attr)
    expect(vote).not_to be_valid
  end

  it 'should only allow a user to vote for an idea once' do
    Vote.create(@attr)
    vote = Vote.new(@attr)
    expect(vote).not_to be_valid
  end
end
