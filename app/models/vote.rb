class Vote < ActiveRecord::Base
  belongs_to :idea, counter_cache: true
  belongs_to :user

  validates :idea, :user, presence: true
  validates :idea, uniqueness: { scope: :user,
                                 message: 'You can only vote an idea once' }

  def self.existing_vote(idea_id, user_id)
    find_by(idea_id: idea_id, user_id: user_id)
  end

  def unlocked?
    unlocked || (created_at > 15.minutes.ago)
  end
end
