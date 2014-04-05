require 'spec_helper'

describe CommentsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
  end

  describe 'POST "create"' do
    it 'should create the comment with valid input' do
      expect{
        post :create, project_id: @project.id, idea_id: @idea.id, comment: { user_id: @user.id, idea_id: @idea.id, comment: "Hello" }
      }.to change{ Comment.count }.by(1)
    end

    it 'should not create the comment' do
      expect{
        post :create, project_id: @project.id, idea_id: @idea.id, comment: { user_id: nil, idea_id: @idea.id, comment: "Hello" }
      }.to change{ Comment.count }.by(0)
    end
  end
end
