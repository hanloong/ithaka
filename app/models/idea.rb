class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments
  has_many :votes

  STATUS = [:created, :dicussing, :planned, :in_progress, :complete, :closed]
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }

  def already_voted?(user_id)
    existing_vote(user_id)
  end

  def vote_unlocked?(user_id)
    existing_vote(user_id).unlocked?
  end

  def existing_vote(user_id)
    Vote.existing_vote(id, user_id)
  end
end
