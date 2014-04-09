class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :comments
  has_many :votes

  delegate :manager?, to: :project

  STATUS = [:discussing, :verified, :planned, :in_progress, :complete, :closed]
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }

  scope :popular, proc { order('votes_count DESC NULLS LAST') }

  def already_voted?(user_id)
    existing_vote(user_id)
  end

  def vote_unlocked?(user_id)
    existing_vote(user_id).unlocked?
  end

  def existing_vote(user_id)
    Vote.existing_vote(id, user_id)
  end

  def unlock_votes
    transaction do
      votes.each do |v|
        v.unlock
      end
    end
  end

  def user_label(u)
    if u.admin?
      'Admin'
    elsif project.champion?(u)
      'Champoin'
    elsif project.manager?(u)
      'Owner'
    end
  end
end
