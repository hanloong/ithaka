module Features
  module SessionHelpers
    def sign_up_with(name, email, password, password_confirmation, company)
      visit '/'
      click_on 'Sign up'

      fill_in 'Company Name', with: company
      fill_in 'Full name', with: name
      fill_in 'Email address', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password_confirmation

      within '.signup-section' do
        click_on "Let's get started"
      end
    end

    def sign_in(user)
      visit new_user_session_path
      fill_in 'Email address', with: user.email
      fill_in 'Password', with: user.password

      within '.contents' do
        click_button "Let's go"
      end
    end

  end
end
