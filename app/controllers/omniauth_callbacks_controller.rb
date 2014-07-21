class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect user
    else
      redirect_to new_user_session_path, alert: 'Ooops, looks like you dont have a valid user account'
    end
  end
end
