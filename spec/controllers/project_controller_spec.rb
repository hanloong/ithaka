require 'spec_helper'

describe ProjectsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @org = @user.organisation
    sign_in @user
  end

  describe 'INDEX "index"' do
    it 'should show all projects' do
      FactoryGirl.create(:project, organisation: @org)
      get :index
      expect(assigns(:projects)).to eq(Project.available(@user.organisation_id))

    end
  end

  describe 'GET "new"' do
    it 'should be successful' do
      get :new
      response.should be_success
    end
  end

  describe 'GET "show"' do
    it 'should find the project' do
      project = FactoryGirl.create(:project, organisation: @org)
      get :show, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'GET "edit"' do
    it 'should find the project' do
      project = FactoryGirl.create(:project, organisation: @org)
      get :edit, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'POST "create"' do
    it 'should create the project with valid input' do
      expect do
        post :create, project: {
          name: 'Name',
          description: 'Test',
          organisation_id: @org.id,
          status: :created
        }
      end.to change { Project.count }.by(1)
    end

    it 'should create the project' do
      post :create, project: { name: '', description: 'Test', status: :created }
      expect(response).to render_template :new
    end
  end

  describe 'PUT "update"' do
    before :each do
      @project = FactoryGirl.create(:project, organisation: @org)
    end

    it 'should update the project with valid input' do
      put :update, id: @project.id,
                   project: {
                     name: 'New Name', description: 'Test'
          }
      @project.reload
      expect(@project.name).to eq('New Name')
    end

    it 'should not project the project' do
      put :update, id: @project.id, project: { name: '' }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delte a valid project' do
      @project = FactoryGirl.create(:project, organisation: @org)
      expect do
        delete :destroy, id: @project.id
      end.to change { Project.count }.by(-1)
    end
  end
end
