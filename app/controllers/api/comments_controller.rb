class Api::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_idea, only: [:index]

  def show
    render json: @comment.to_json(only: [:id, :comment], include: :user)
  end

  def create
  end

  def update
  end

  def index
    render json: @idea.comments.to_json(only: [:id, :comment], include: :user)
  end

  def destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_idea
    @idea = Idea.find(params[:idea_id])
  end
end
