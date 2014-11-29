class Comment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Trackable

  belongs_to :user
  belongs_to :idea
  before_create :set_user

  validates :idea, :comment, presence: true
  validates :user, presence: true, unless: -> { idea && idea.allow_anonymous }

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :available, -> (organisation) { where(idea_id: Idea.available(organisation)) }

  delegate :project, to: :idea
  delegate :organisation, to: :idea
  delegate :public, to: :idea

  def search_title
    comment.truncate(40)
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
