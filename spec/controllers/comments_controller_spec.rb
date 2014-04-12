require 'spec_helper'

describe CommentsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, organisation: @user.organisation)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
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
                      comment: { user_id: nil, idea_id: @idea.id, comment: 'Hello' }
      end.to change { Comment.count }.by(0)
    end
  end

  describe 'PUT "update"' do
    it 'should set comment to hidden' do
      comment = FactoryGirl.create(:comment, idea: @idea, user: @user)
      put :update, project_id: @project.id, idea_id: @idea.id, id: comment.id,
                    comment: { hidden: true }
      comment.reload
      expect(comment.hidden).to be_true
    end

    it 'should set comment to hidden' do
      comment = FactoryGirl.create(:comment, idea: @idea, user: @user)
      Comment.any_instance.stub(:update).and_return(false)
      put :update, project_id: @project.id, idea_id: @idea.id, id: comment.id,
                    comment: { hidden: true }
      expect(flash[:alert]).to eq('Comment not saved.')
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a valid comment' do
      comment = FactoryGirl.create(:comment, idea: @idea, user: @user)
      expect do
        delete :destroy, project_id: @project.id, idea_id: @idea.id, id: comment.id
      end.to change { Comment.count }.by(-1)
    end
  end
end
