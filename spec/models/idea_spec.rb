require 'spec_helper'

describe Idea do
  before :each do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    @attr = {
      name: 'Best idea eva',
      description: 'make all the things',
      user: user,
      project: project,
      status: 1
    }
  end

  it 'should create an idea given valid input' do
    idea = Idea.new(@attr)
    expect(idea).to be_valid
  end

  context 'invalid when' do
    it 'name is blank'  do
      @attr[:name] = nil
      idea = Idea.new(@attr)
      expect(idea).not_to be_valid
    end

    it 'description is blank'  do
      @attr[:description] = nil
      idea = Idea.new(@attr)
      expect(idea).not_to be_valid
    end

    it 'description is blank'  do
      @attr[:user] = nil
      idea = Idea.new(@attr)
      expect(idea).not_to be_valid
    end

    it 'project is blank'  do
      @attr[:project] = nil
      idea = Idea.new(@attr)
      expect(idea).not_to be_valid
    end

    it 'status is blank'  do
      @attr[:status] = nil
      idea = Idea.new(@attr)
      expect(idea).not_to be_valid
    end
  end

  it 'should be unique for each project' do
    Idea.create(@attr)
    idea = Idea.new(@attr)
    expect(idea).not_to be_valid
  end

  it 'can see if a user has already voted' do
    idea = Idea.new(@attr)
    vote = mock_model('Vote', id: 1)
    Vote.stub existing_vote: vote
    expect(idea.already_voted?(1)).to equal(vote)
  end

  it "can see if a user hasn't already voted" do
    idea = Idea.new(@attr)
    Vote.stub existing_vote: nil
    expect(idea.already_voted?(1)).to be_nil
  end

  it 'should show when know when a users vote is unlcoked' do
    vote = mock_model('Vote', id: 1, :unlocked? => true)
    Vote.stub existing_vote: vote

    idea = Idea.new(@attr)
    expect(idea.vote_unlocked?(1)).to be_true
  end
end
