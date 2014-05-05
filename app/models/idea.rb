class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :influences, dependent: :destroy

  STATUS = ["discussing", "verified", "planned", "in_progress", "complete", "closed", "archived"]
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }

  delegate :manager?, to: :project
  delegate :name, to: :project, prefix: true
  delegate :public, to: :project
  delegate :organisation, to: :project

  scope :popular, proc { order('score DESC NULLS LAST') }

  after_create :setup_influence

  def self.status_collection
    STATUS.collect do |s|
      [ s.gsub(/_/, ' ').split.map(&:capitalize).join(' '), s ]
    end
  end

  def self.readable_statuses(index)
    STATUS[index].gsub(/_/, ' ').split.map(&:capitalize).join(' ')
  end

  def self.status_group
    Hash[group(:status).count.map{ |k,v| [readable_statuses(k), v] }]
  end

  def self.search_status
    STATUS.select{ |s| s != "archived" }
  end

  def readable_status
    status.gsub(/_/, ' ').split.map(&:capitalize).join(' ')
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

  def setup_influence
    Factor.all.each do |f|
      Influence.create(idea_id: id, factor: f, score: 0)
    end
  end

  def calculate_influence
    self.influence = (((influences.only_positive.sum(:score) - influences.only_negative.sum(:score)) / 100.0) + 1.0).round(2)
    self.score = (votes.count * influence).round(2) if votes.count
    save
  end
end
