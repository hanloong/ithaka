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

  delegate :name, to: :project, prefix: true
  delegate :public, to: :project
  delegate :organisation, to: :project
  delegate :sandbox, to: :project
  delegate :allow_anonymous, to: :project

  validates :name, :description, :status, :project, presence: true
  validates :user, presence: true, unless: -> { project && project.allow_anonymous }
  validates :name, uniqueness: { scope: :user_id }

  before_create :set_user

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
    return unless u
    return 'Admin' if u.admin?
    return 'Champion' if project.champion?(u)
    return 'Owner' if project.manager?(u)
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

  private

  def set_user
    self.user = nil if anonymous && allow_anonymous
  end
end
