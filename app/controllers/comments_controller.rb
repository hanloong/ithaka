class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to project_idea_path(@comment.idea.project, @comment.idea),
                  notice: 'Comment created.'
    else
      redirect_to project_idea_path(@comment.idea.project, @comment.idea),
                  notice: 'Comment not created.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :idea_id)
  end
end
