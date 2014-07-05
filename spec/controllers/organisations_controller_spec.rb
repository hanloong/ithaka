require 'spec_helper'

describe OrganisationsController do
  before :each do
    @user = create(:user)
    sign_in @user
  end


  describe 'GET "edit"' do
    it 'should assign current org' do
      get :edit
      expect(assigns(:organisation)).to eq(@user.organisation)
    end
  end

  describe 'PUT "update"' do
    it 'should update with valid inputs' do
      put :update, organisation: {name: 'New Name'}
      @user.organisation.reload
      expect(@user.organisation.name).to eq('New Name')
    end

    it 'should require a name' do
      name = @user.organisation.name
      put :update, organisation: {name: ''}
      @user.organisation.reload
      expect(@user.organisation.name).to eq(name)
    end
  end

end
