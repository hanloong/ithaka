class Idea < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Trackable

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
  after_create :setup_influence

  scope :popular, -> { order('score DESC NULLS LAST') }
  scope :available, -> (organisation) { where(project_id: Project.available(organisation)) }

  acts_as_taggable

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
    calculate_influence
  end

  def calculate_influence
    temp_influence = (((influences.only_positive.sum(:score) - influences.only_negative.sum(:score)) / 100.0) + 1.0).round(2)
    temp_score = (votes.count * influence).round(2) if votes.count
    update_columns(influence: temp_influence, score: temp_score)
  end

  def manager?(u)
    project.manager?(u) || sandbox && u == user
  end

  def search_title
    name
  end

  def search_body
    description
  end

  def link_to
    project_idea_path(project, self)
  end

  private

  def set_user
    self.user = nil if anonymous && allow_anonymous
  end

  def track_update_message
    if status_changed?
      "#{self.class.name}: #{name} status was changed to #{status}."
    elsif name_changed? || description_changed?
      "#{self.class.name}: #{name} was updated."
    end
  end
end
