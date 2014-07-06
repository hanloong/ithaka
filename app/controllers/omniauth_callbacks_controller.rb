class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    raise request.env["omniauth.auth"]
  end
end
