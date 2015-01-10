class Api::AbstractController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user_from_token!
  before_action :verify_current_user!
  skip_before_action :verify_authenticity_token, if: :json_request?
  respond_to :json

  protected

  def json_request?
    request.format.json?
  end

  def verify_current_user!
    unless current_user
      render json: {error: 'Must be authenticated to access this resource'}, status: 401
    end
  end
end
