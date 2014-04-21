class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :comments
  has_many :votes
  has_many :favourites
  has_many :influences

  STATUS = ["discussing", "verified", "planned", "in_progress", "complete", "closed"]
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }

  delegate :manager?, to: :project
  delegate :name, to: :project, prefix: true
  delegate :public, to: :project
  delegate :organisation, to: :project

  scope :popular, proc { order('score DESC NULLS LAST') }

  def self.status_collection
    STATUS.collect do |s|
      [ s.gsub(/_/, ' ').split.map(&:capitalize).join(' '), s ]
    end
  end

  def vote_unlocked?(user_id)
    existing_vote(user_id).unlocked?
  end

  def existing_vote(user_id)
    Vote.existing_vote(id, user_id)
  end

  def existing_favourite(user_id)
    Favourite.existing_favourite(id, user_id)
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
      'Champion'
    elsif project.manager?(u)
      'Owner'
    end
  end

  def calculate_influence
    self.influence = ((influences.only_positive.sum(:score) - influences.only_negative.sum(:score)) / 100.0) + 1.0
    calculate_score
    save
  end

  def calculate_score
    if votes_count
      self.score = (votes_count * influence)
      save
    end
  end
end
