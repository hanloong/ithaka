class Vote < ActiveRecord::Base
  include Trackable

  belongs_to :idea, counter_cache: true
  belongs_to :user

  validates :idea, :user, presence: true
  validates :idea, uniqueness: { scope: :user,
                                 message: 'You can only vote for an idea once' }

  delegate :calculate_influence, to: :idea
  delegate :project, to: :idea
  delegate :link_to, to: :idea
  default_scope proc { where(public: false) }

  after_create :calculate_influence
  after_destroy :calculate_influence

  scope :existing_vote, -> (user_id) { where(user_id: user_id) }
  scope :available, -> (organisation) { where(idea_id: Idea.available(organisation)) }

  def unlocked?
    unlocked || (created_at > 15.minutes.ago)
  end

  def unlock
    update(unlocked: true)
  end

  def name
    nil
  end
end
