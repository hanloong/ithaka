class Vote < ActiveRecord::Base
  belongs_to :idea, counter_cache: true
  belongs_to :user

  validates :idea, :user, presence: true
  validates :idea, uniqueness: { scope: :user,
                                 message: 'You can only vote for an idea once' }

  delegate :calculate_influence, to: :idea
  default_scope proc { where(public: false) }

  after_create :calculate_influence
  after_destroy :calculate_influence

  def self.existing_vote(idea_id, user_id)
    unscoped.find_by(idea_id: idea_id, user_id: user_id)
  end

  def unlocked?
    unlocked || (created_at > 15.minutes.ago)
  end

  def unlock
    update(unlocked: true)
  end
end
