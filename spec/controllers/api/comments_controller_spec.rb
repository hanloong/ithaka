require 'rails_helper'

describe Api::CommentsController, type: :controller do
  before :each do
    @user = create(:user)
    @project = create(:project, organisation: @user.organisation)
    @idea = create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'GET "index"' do
    it 'should return json' do
      create(:comment, idea: @idea, user: @user)
      get :index, format: :json, project_id: @project.id, idea_id: @idea.id
      json = Comment.all.to_json(only: [:id, :comment], include: :user)
      expect(response.body).to eq(json)
    end
  end

  describe 'GET "show"' do
    it 'should return json' do
      comment = create(:comment, idea: @idea, user: @user)
      get :show, format: :json, project_id: @project.id, idea_id: @idea.id, id: comment.id
      json = comment.to_json(only: [:id, :comment], include: :user)
      expect(response.body).to eq(json)
    end
  end
end
