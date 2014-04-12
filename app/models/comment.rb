class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :idea, :user, :comment, presence: true

  scope :visible, proc { where(hidden: false) }
  scope :hidden, proc { where(hidden: true) }
end
