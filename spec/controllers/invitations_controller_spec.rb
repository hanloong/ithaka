require 'spec_helper'

describe InvitationsController do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST "create"' do
    it 'should register new user' do
      user = create(:user)
      sign_in user
      expect do
        post :create, user: { name: 'test', email: 'fread@test.com', role: :user }
      end.to change{
        User.count
      }.by(1)
    end
  end
end
