class SearchController < ApplicationController
  def index
    if hit = direct_hit(search_params)
      redirect_to hit.link_to
    else
      @results = Search.for(current_user, search_params)
    end
  end

  private

  def search_params
    params[:keyword]
  end

  def direct_hit(name)
    if target = Project.available(current_user.organisation).find_by(name: name)
      target
    end
  end

end
