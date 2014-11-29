class SearchController < ApplicationController
  def index
    @results = Search.for(search_params)
  end

  private

  def search_params
    params[:keyword]
  end

  def direct_hit

  end

end
