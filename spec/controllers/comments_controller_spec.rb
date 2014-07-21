require 'spec_helper'

describe CommentsController do
  before :each do
    @user = create(:user)
    @project = create(:project, organisation: @user.organisation)
    @idea = create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'POST "create"' do
    it 'should create the comment with valid input' do
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      comment: { user_id: @user.id, idea_id: @idea.id, comment: 'Hello' }
      end.to change { Comment.count }.by(1)
    end

    it 'should not create the comment' do
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      comment: {  idea_id: @idea.id, comment: nil }
      end.to change { Comment.count }.by(0)
    end
  end

  describe 'PUT "update"' do
    it 'should set comment to hidden' do
      comment = create(:comment, idea: @idea, user: @user)
      put :update, project_id: @project.id, idea_id: @idea.id, id: comment.id,
                   comment: { hidden: true }
      comment.reload
      expect(comment.hidden).to be_truthy
    end

    it 'should set comment to hidden' do
      comment = create(:comment, idea: @idea, user: @user)
      allow_any_instance_of(Comment).to receive(:update).and_return(false)
      put :update, project_id: @project.id, idea_id: @idea.id, id: comment.id,
                   comment: { hidden: true }
      expect(flash[:alert]).to eq('Comment not saved.')
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a valid comment' do
      comment = create(:comment, idea: @idea, user: @user)
      expect do
        delete :destroy, project_id: @project.id, idea_id: @idea.id, id: comment.id
      end.to change { Comment.count }.by(-1)
    end
  end
end
