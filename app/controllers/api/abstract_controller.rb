class Api::AbstractController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user_from_token!
  skip_before_action :verify_authenticity_token, if: :json_request?
  respond_to :json

  protected

  def json_request?
    request.format.json?
  end
end
