require 'spec_helper'

describe ProjectsController do
  before :each do
    @user = create(:user)
    @org = @user.organisation
    sign_in @user
  end

  describe 'GET "index"' do
    it 'should show all projects' do
      create(:project, organisation: @org)
      get :index
      expect(assigns(:projects).count).to eq(Project.available(@user.organisation).count)

    end
  end

  describe 'GET "new"' do
    it 'should be successful' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'GET "show"' do
    it 'should find the project' do
      project = create(:project, organisation: @org)
      get :show, id: project.id
      expect(assigns(:project)).to eq(project)
    end

    it 'should redirect if project not yours' do
      project = create(:project, organisation: @org)
      allow_any_instance_of(Project).to receive(:has_access?).and_return(false)
      get :show, id: project.id
      expect(response).to redirect_to projects_path
    end

    it 'should filter ideas based on search params' do
      project = create(:project, organisation: @org)
      idea = create(:idea, name: 'test idea', project: project, user: @user)
      create(:idea, name: 'another idea', project: project, user: @user)
      get :show, id: project.id, search: { keywords: 'test', status: Idea::STATUS }
      expect(assigns(:ideas)).to eq([idea])
    end
  end

  describe 'GET "edit"' do
    it 'should find the project' do
      project = create(:project, organisation: @org)
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
      @project = create(:project, organisation: @org)
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
      @project = create(:project, organisation: @org)
      expect do
        delete :destroy, id: @project.id
      end.to change { Project.count }.by(-1)
    end
  end
end
