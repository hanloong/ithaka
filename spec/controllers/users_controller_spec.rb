require 'spec_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'INDEX "index"' do
    it 'should show all users' do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "GET 'show'" do

    it 'should be successful' do
      get :show, id: @user.id
      response.should be_success
    end

    it 'should find the right user' do
      get :show, id: @user.id
      assigns(:user).should == @user
    end

    it 'should not allow view other user' do
      user2 = FactoryGirl.create(:user, :other_email)
      get :show, id: user2.id
      expect(response).to redirect_to root_path
    end

  end

  describe 'PUT "update"' do
    before :each do
      @user.update(role: :admin)
    end

    it 'should update the user with valid input' do
      put :update, id: @user.id,
                   user: {
                     name: 'New Name'
          }
      @user.reload
      expect(@user.name).to eq('New Name')
    end

    it 'should not update the user' do
      put :update, id: @user.id, user: { name: '' }
      expect(flash[:alert]).to eq('Unable to update user.')
    end
  end

  describe 'DELETE "destroy"' do
    before :each do
      @user.update(role: :admin)
    end

    it 'should allow deleteion of other user' do
      user2 = FactoryGirl.create(:user, :other_email)
      expect do
        delete :destroy, id: user2.id
      end.to change { User.count }.by(-1)
    end

    it 'should block form deleting yourself' do
      expect do
        delete :destroy, id: @user.id
      end.to change { User.count }.by(0)
    end

  end

  it 'should stop normal users from seeing admin' do
    user = FactoryGirl.create(:user, :other_email)
    sign_in user
    @request.env['HTTP_REFERER'] = 'test'
    get :index
    expect(request).to redirect_to 'test'
  end

end
