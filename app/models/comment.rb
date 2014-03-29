class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :idea, :user, :comment, presence: true
end
