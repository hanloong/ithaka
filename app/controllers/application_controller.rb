class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if stored_location_for(resource)
      stored_location_for(resource)
    else
      projects_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    if request.referrer
      redirect_to request.referrer
    else
      redirect_to root_path
    end
  end
end
