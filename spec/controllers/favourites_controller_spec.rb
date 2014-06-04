require 'spec_helper'

describe FavouritesController do
  before :each do
    org = FactoryGirl.create(:organisation)
    @user = FactoryGirl.create(:user, organisation: org)
    @project = FactoryGirl.create(:project, organisation: org)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'POST "create"' do
    it 'should create the favourite' do
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      favourite: { user_id: @user.id, idea_id: @idea.id }
      end.to change { Favourite.count }.by(1)
    end
    it 'should not allow duplicate favourites' do
      FactoryGirl.create(:favourite, idea: @idea, user: @user)
      expect do
        post :create, project_id: @project.id, idea_id: @idea.id,
                      favourite: { user_id: @user.id, idea_id: @idea.id }
      end.not_to change { Favourite.count }
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a valid favourite' do
      favourite = FactoryGirl.create(:favourite, idea: @idea, user: @user)
      expect do
        delete :destroy, project_id: @project.id, idea_id: @idea.id, id: favourite.id
      end.to change { Favourite.count }.by(-1)
    end
  end
end
