require 'spec_helper'

describe ReportsController do

  before :each do
    @user = FactoryGirl.create(:user)
    @org = @user.organisation
    sign_in @user
  end

  describe 'INDEX "index"' do
    it 'should show all projects' do
      FactoryGirl.create(:project, organisation: @org)
      get :index
      expect(assigns(:projects).count).to eq(Project.available(@user.organisation).count)
      expect(assigns(:status_presenter)).not_to be_nil
    end
  end
end
