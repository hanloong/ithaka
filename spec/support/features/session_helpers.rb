module Features
  module SessionHelpers
    def sign_up_with(name, email, password, password_confirmation, company)
      visit '/'
      click_on 'Sign up'

      fill_in 'Company Name', with: company
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password_confirmation

      within '.signup-section' do
        click_on 'Create account'
      end
    end

    def sign_in(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within '.contents' do
        click_button 'Login'
      end
    end

  end
end
