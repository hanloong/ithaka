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
    vote1 = Vote.create(@attr)
    vote2 = Vote.new(@attr)
    expect(Vote.existing_vote(vote1.idea_id, vote1.user_id)).to eq(vote1)
    expect(vote2).not_to be_valid
  end

  it "is unlocked when it is new"  do
    vote = Vote.create(@attr)
    expect(vote.unlocked?).to be_true
  end

  it "is unlocked when it is new"  do
    vote = Vote.create(@attr)
    expect(vote.unlocked?).to be_true
  end

  it "is locked when old"  do
    Timecop.freeze(Date.today - 1) do
      Vote.create(@attr)
    end
    expect(Vote.first.unlocked?).to be_false
  end

  it "is locked when old"  do
    Timecop.freeze(Date.today - 1) do
      Vote.create(@attr)
    end

    vote = Vote.first
    vote.unlocked = false

    expect(vote.unlocked?).to be_false
  end
end
