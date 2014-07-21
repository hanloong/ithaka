class GoogleAppsUsersService
  include ActiveModel::Model

  OAUTH_SCOPE = 'https://www.googleapis.com/auth/admin.directory.user'
  attr_accessor :code, :client, :drive, :redirect

  def connect
    setup
    auth
  end

  def setup
    @client = Google::APIClient.new
    @drive = client.discovered_api('admin', 'directory_v1')
  end

  def verify
    setup
    auth
    @client.authorization.code = code
    @client.authorization.fetch_access_token!
  end

  def auth
    @client.authorization.client_id = '913471864089-lhcf3oqst2ugsseup6pdr9vpmmbbafqc.apps.googleusercontent.com'
    @client.authorization.client_secret = 'XIvnX9_p3C_v19BoGgZ3T23l'
    @client.authorization.scope = OAUTH_SCOPE
    @client.authorization.redirect_uri = redirect
    @client.authorization.authorization_uri
  end
end
