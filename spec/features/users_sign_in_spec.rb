require 'spec_helper'

feature 'Users can sign in' do
  scenario 'with a valid account' do
    user = create(:user)
    sign_in user
    within '.navbar' do
      expect(page).to have_content('Logout')
    end
  end

  scenario 'with a valid account' do
    user = User.new(email: 'test@email.com', password: 'test123123')
    sign_in user
    within '.navbar' do
      expect(page).to have_content('Sign up')
    end
  end
end
