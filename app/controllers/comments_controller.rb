class CommentsController < ApplicationController
  before_action :authenticate_user!

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

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :idea_id)
  end
end
