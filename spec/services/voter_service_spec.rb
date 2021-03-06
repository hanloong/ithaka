require 'spec_helper'

describe VoterService do
  before do
    user = create(:user)
    project = create(:project, organisation: user.organisation)
    idea = create(:idea, project: project, user: user)
    @attr = {
      user: user,
      idea: idea
    }
  end

  it 'builds a new vote object' do
    vs = VoterService.new(@attr)
    expect(vs.vote).to be_an(Vote)
  end

  it 'should save vote when cast' do
    vs = VoterService.new(@attr)
    expect(vs.vote).to receive(:save)
    vs.place
  end

  it 'should reject vote when user reached limit' do
    vs = VoterService.new(@attr)
    @attr[:user].organisation.update(vote_limit: 0)
    expect(vs.place).to be_falsy
  end
end
