require 'spec_helper'

describe VotesController do
  before :each do
    org = create(:organisation)
    @user = create(:user, organisation: org)
    @project = create(:project, organisation: org)
    @idea = create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'POST "create"' do
    it 'should create the vote with valid input' do
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      vote: { user_id: @user.id, idea_id: @idea.id }
      end.to change { Vote.count }.by(1)
    end

    it 'should not create the vote if no user' do
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      vote: { user_id: nil, idea_id: @idea.id }
      end.to change { Vote.count }.by(0)
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a unlocked vote' do
      @vote = create(:vote, idea: @idea, user: @user, unlocked: true)
      expect do
        delete :destroy, id: @vote.id, project_id: @project.id, idea_id: @idea
      end.to change { Vote.count }.by(-1)
    end
  end

end
