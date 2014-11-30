class Api::EventsController < ApplicationController
  def index
    render json: Event.recent_for(current_user)
  end
end
