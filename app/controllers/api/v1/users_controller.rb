class Api::V1::UsersController < Api::AbstractController
  def current
    render json: current_user
  end

  def index
    render json: User.all
  end
end
