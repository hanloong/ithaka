class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:show]

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    if user == current_user
      redirect_to users_path, notice: "Can't delete yourself."
    else
      user.destroy
      redirect_to users_path, notice: 'User deleted.'
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
end
