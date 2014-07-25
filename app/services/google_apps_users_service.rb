class GoogleAppsUsersService
  include ActiveModel::Model

  OAUTH_SCOPE = 'https://www.googleapis.com/auth/admin.directory.user'
  attr_accessor :client, :drive, :callback

  def connect
    authenticate
  end

  def fetch_users(code)
    authenticate
    @client.authorization.code = code
    @client.authorization.fetch_access_token!
    params = {customer: 'my_customer',
              maxResults: 500}
    result = @client.execute(api_method: @directory.users.list, parameters: params)
    if result.response.status == 200
      result.data.to_hash['users']
    end
  end

  private

  def setup
    @client = Google::APIClient.new
    @directory = client.discovered_api('admin', 'directory_v1')
  end

  def authenticate
    setup
    @client.authorization.client_id = '913471864089-lhcf3oqst2ugsseup6pdr9vpmmbbafqc.apps.googleusercontent.com'
    @client.authorization.client_secret = 'XIvnX9_p3C_v19BoGgZ3T23l'
    @client.authorization.scope = OAUTH_SCOPE
    @client.authorization.redirect_uri = callback
    @client.authorization.authorization_uri
  end
end
