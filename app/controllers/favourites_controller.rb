class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite, only: [:destroy]

  def create
    favourite = Favourite.new(favourite_params)
    if favourite.save
      redirect_to project_idea_path(favourite.idea.project, favourite.idea),
                  notice: "you are now following #{favourite.idea.name}"
    else
      redirect_to project_idea_path(favourite.idea.project, favourite.idea),
                  error: 'there was a problem trying to follow that idea'
    end
  end

  def destroy
    @favourite.destroy
    redirect_to project_idea_path(@favourite.idea.project, @favourite.idea),
                notice: 'Un-follow complete.'
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end

  def favourite_params
    params.require(:favourite).permit(:user_id, :idea_id)
  end

end
