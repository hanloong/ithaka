class GoogleAdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisation

  def callback
    begin
      service = GoogleAppsUsersService.new(callback: callback_google_admin_url)
      @users = service.fetch_users(auth_code)
      if current_user.admin?
        @roles = User.roles
      else
        @roles = User.roles.reject{|role| role == 'admin'}
      end
      render :invite and return
    rescue
      redirect_to edit_organisation_path, alert: 'Oh no, we couldn\'t authenticate you. Please try again or contact support'
    end
  end

  def show
    service = GoogleAppsUsersService.new(callback: callback_google_admin_url)
    redirect_to service.connect.to_str
  end

  def invite_all
    invites = params[:invite]
    if invites
      invites.each do |k, v|
        if v == 'true'
          password = (0...8).map { (65 + rand(26)).chr }.join
          User.create(email: params[:email][k],
                      name: params[:name][k],
                      role: params[:role][k],
                      photo_url: params[:photo][k],
                      password: password,
                      password_confirmation: password,
                      organisation: @organisation)
        end
      end
    end
    redirect_to edit_organisation_path, notice: 'Invites have been sent out'
  end

  private

  def auth_code
    params['code']
  end

  def set_organisation
    @organisation = current_user.organisation
  end
end
