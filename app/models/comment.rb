class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :idea, :user, :comment, presence: true

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :available, -> (organisation) { where(idea_id: Idea.available(organisation)) }

end
