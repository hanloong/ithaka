require 'spec_helper'

describe FactorsController do
  before :each do
    @user = create(:user)
    @project = create(:project, organisation: @user.organisation)
    @factor = create(:factor, project: @project)
    sign_in @user
  end

  describe 'GET "index"' do
    it 'should show factors' do
      get :index, project_id: @project.id
      expect(assigns(:factors)).to eq([@factor])
    end
  end

  describe 'POST "create"' do
    it 'should create the factor with valid input' do
      expect do
        post :create, project_id: @project.id,
                      factor: { name: 'Name',
                                is_negative: :true }
      end.to change { Factor.count }.by(1)
    end

    it 'should not create the factor with no name' do
      expect do
        post :create, project_id: @project.id,
                      factor: { name: '',
                                is_negative: :true }
      end.not_to change { Factor.count }
    end
  end

  describe 'PUT "update"' do
    it 'should update the factor with valid input' do
      put :update, id: @factor.id, project_id: @project.id,
                   factor: { name: 'New Name' }
      @factor.reload
      expect(@factor.name).to eq('New Name')
    end

    it 'should not update the factor' do
      name = @factor.name
      put :update, id: @factor.id, project_id: @project.id, factor: { name: '' }
      @factor.reload
      expect(@factor.name).to eq(name)
    end
  end

  describe 'DELETE "destroy"' do
    it 'should delete a valid factor' do
      expect do
        delete :destroy, id: @factor.id, project_id: @project.id
      end.to change { Factor.count }.by(-1)
    end
  end

end
