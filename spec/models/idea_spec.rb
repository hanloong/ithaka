require 'spec_helper'

describe Idea do
  before :each do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, organisation: user.organisation)
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

  it 'should show when know when a users vote is unlcoked' do
    vote = mock_model('Vote', id: 1, unlocked?: true)
    Vote.stub existing_vote: vote

    idea = Idea.new(@attr)
    expect(idea.vote_unlocked?(1)).to be_true
  end

  it 'should return favourtes that exist' do
    fav = mock_model('Favourite', id: 1)
    Favourite.stub existing_favourite: fav

    idea = Idea.new(@attr)
    expect(idea.existing_favourite(1)).to eq(fav)
  end

  it 'should unlock associated votes' do
    idea = Idea.create(@attr)
    Timecop.freeze(Date.today - 1) do
      (1..4).each do |i|
        user = FactoryGirl.create(:user, email: "test#{i}@email.com")
        FactoryGirl.create(:vote, idea: idea, user: user)
      end
    end

    expect do
      idea.unlock_votes
    end.to change{
      idea.votes.sample.unlocked?
    }.from(false).to(true)
  end

  it 'should create influences on create' do
    FactoryGirl.create(:factor)
    idea = Idea.create(@attr)
    expect(idea.influences.count).to eq(1)
  end

  describe 'user labels' do
    it 'should show admin' do
      admin = FactoryGirl.create(:user, email: 'admin@test.com', role: :admin)
      idea = Idea.create(@attr)
      expect(idea.user_label(admin)).to eq('Admin')
    end

    it 'should show chapion' do
      user = FactoryGirl.create(:user, email: 'admin@test.com')
      idea = Idea.create(@attr)
      idea.project.update(user: user)
      expect(idea.user_label(user)).to eq('Champion')
    end

    it 'should show manager' do
      idea = Idea.create(@attr)
      user = FactoryGirl.create(:user, email: 'admin@test.com',
                                role: :owner,
                                organisation: idea.project.organisation)
      expect(idea.user_label(user)).to eq('Owner')
    end

    it 'should be nil for normal user' do
      idea = Idea.create(@attr)
      user = FactoryGirl.create(:user, email: 'admin@test.com', role: :user,
                                organisation: idea.project.organisation)
      expect(idea.user_label(user)).to be_nil
    end

    it 'should return a formatted collection' do
      stub_const('Idea::STATUS', ['test_status'])
      expect(Idea.status_collection.include?(['Test Status', 'test_status'])).to be_true
    end

    it "should return a readable status" do
      statuses = Hash[Idea::STATUS.map.with_index.to_a]
      @attr[:status] = statuses['in_progress']
      idea = Idea.create(@attr)
      expect(idea.readable_status).to eq("In Progress")
    end
  end
end
