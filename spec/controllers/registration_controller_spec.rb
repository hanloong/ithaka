require 'spec_helper'

describe RegistrationsController do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST "create"' do
    it 'should register new user' do
      post :create, user: { name: 'test', email: 'fread@test.com' }
      expect(response).to be_successful
    end
  end

  describe 'PUT "update"' do
    it 'should register new user' do
      user = create(:user)
      sign_in user
      put :update, id: user.id, user: { name: 'new name' }
      expect(response).to be_successful
    end
  end

end
