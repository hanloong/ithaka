class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_one :organisation, through: :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :influences, dependent: :destroy
  has_many :factors, through: :project

  STATUS = %w(discussing verified planned in_progress complete closed archived)
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }

  delegate :name, to: :project, prefix: true
  delegate :public, to: :project
  delegate :organisation, to: :project
  delegate :sandbox, to: :project

  scope :popular, -> { order('score DESC NULLS LAST') }
  scope :available, -> (organisation) { where(project_id: Project.available(organisation)) }

  after_create :setup_influence

  def vote_unlocked?(user_id)
    existing_vote(user_id).unlocked?
  end

  def existing_vote(user_id)
    votes.existing_vote(user_id).first
  end

  def existing_favourite(user_id)
    favourites.existing_favourite(user_id).first
  end

  def unlock_votes
    transaction { votes.map(&:unlock) }
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
    factors.each do |f|
      Influence.create(idea_id: id, factor: f, score: 0)
    end
  end

  def calculate_influence
    self.influence = (((influences.only_positive.sum(:score) - influences.only_negative.sum(:score)) / 100.0) + 1.0).round(2)
    self.score = (votes.count * influence).round(2) if votes.count
    save
  end

  def manager?(u)
    project.manager?(u) || sandbox && u == user
  end
end
