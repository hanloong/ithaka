module AuthHelper
  def http_login
    user = 'votation'
    pw = 'hidden'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end
