class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]

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

  def update
    if @comment.update(comment_params)
      redirect_to project_idea_path(@comment.idea.project, @comment.idea),
                  notice: 'Changes saved to comment.'
    else
      redirect_to project_idea_path(@comment.idea.project, @comment.idea),
                  alert: 'Comment not saved.'
    end
  end

  def destroy
    idea = @comment.idea
    @comment.destroy
    redirect_to project_idea_path(idea.project, idea),
                notice: 'Comment removed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :idea_id, :hidden, :anonymous)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
