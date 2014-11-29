class Comment < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :idea
  before_create :set_user

  validates :idea, :comment, presence: true
  validates :user, presence: true, unless: -> { idea && idea.allow_anonymous }

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :available, -> (organisation) { where(idea_id: Idea.available(organisation)) }

  delegate :project, to: :idea

  def search_title
    "Comment on #{idea.name}"
  end

  def search_body
    comment
  end

  def link_to
    project_idea_path(project, idea)
  end

  private

  def set_user
    self.user = nil if anonymous && idea.allow_anonymous
  end

end
