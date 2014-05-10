require 'spec_helper'

describe InfluencesController do
  before :each do
    org = FactoryGirl.create(:organisation)
    @user = FactoryGirl.create(:user, organisation: org)
    @project = FactoryGirl.create(:project, organisation: org)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    FactoryGirl.create(:factor)
    sign_in @user
  end

  describe 'PUT "update"' do
    it 'should update influcne score if manager' do
      expect do
        put :update, format: :js, project_id: @project.id, idea_id: @idea.id, id: Influence.first.id,
                     influence: { score: 50 }
      end.to change { Influence.first.score }.from(0).to(50)
    end

    it 'should not update influcne score if not manager' do
      @user.update(role: :user)
      expect do
        put :update, format: :js, project_id: @project.id, idea_id: @idea.id, id: Influence.first.id,
                     influence: { score: 50 }
      end.not_to change { Influence.first.score }.from(0).to(50)
    end
  end
end
