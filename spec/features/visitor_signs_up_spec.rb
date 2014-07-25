require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid details' do
    password = 'testlongpassword'
    sign_up_with 'Fred', 'test@email.com', password, password, 'Monsters Inc'

    within '.navbar' do
      expect(page).to have_link('Logout')
    end
  end

  scenario 'with invalid email' do
    password = 'testlongpassword'
    sign_up_with 'Fred', 'testat.email.com', password, password, 'Monsters Inc'

    within '.navbar' do
      expect(page).to have_content('Sign up')
    end
  end

  scenario 'with invalid passwrd' do
    password = 'a'
    sign_up_with 'Fred', 'test@email.com', password, password, 'Monsters Inc'

    within '.navbar' do
      expect(page).to have_content('Sign up')
    end

    sign_up_with 'Fred', 'test@email.com', 'passwordlong123', 'longnonmatchingpassword', 'Monsters Inc'

    within '.navbar' do
      expect(page).to have_content('Sign up')
    end
  end

  scenario 'with duplicate email' do
    email = 'test@email.com'
    password = 'passwordlong123'
    create(:user, email: email)
    sign_up_with 'Fred', email, password, password, 'Monsters Inc'

    within '.navbar' do
      expect(page).to have_content('Sign up')
    end
  end
end
