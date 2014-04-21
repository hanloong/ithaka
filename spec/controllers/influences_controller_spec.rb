require 'spec_helper'

describe InfluencesController do
  before :each do
    org = FactoryGirl.create(:organisation)
    @user = FactoryGirl.create(:user, organisation: org)
    @project = FactoryGirl.create(:project, organisation: org)
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    sign_in @user
  end

  describe 'PATCH "update"' do
  end

end
