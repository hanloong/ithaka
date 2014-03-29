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
end
