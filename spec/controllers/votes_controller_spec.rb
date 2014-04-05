require 'spec_helper'

describe VotesController do
  before :each do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'POST "create"' do
    it 'should create the vote with valid input' do
      expect{
        post :create, project_id: @project.id, idea_id: @idea.id, vote: { user_id: @user.id, idea_id: @idea.id }
      }.to change{ Vote.count }.by(1)
    end

    it 'should not create the vote if no user' do
      expect{
        post :create, project_id: @project.id, idea_id: @idea.id, vote: { user_id: nil, idea_id: @idea.id }
      }.to change{ Vote.count }.by(0)
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a unlocked vote' do
      @vote = FactoryGirl.create(:vote, idea: @idea, user: @user, unlocked: true)
      expect{
        delete :destroy, id: @vote.id, project_id: @project.id, idea_id: @idea
      }.to change{ Vote.count }.by(-1)
    end
  end

end
