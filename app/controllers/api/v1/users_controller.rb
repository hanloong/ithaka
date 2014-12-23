class Api::V1::UsersController < ApiController

  def current
    render json: current_user
  end

  def index
    render json: User.all
  end

  private


end
