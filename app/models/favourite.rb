class Favourite < ActiveRecord::Base
  belongs_to :idea, counter_cache: true
  belongs_to :user

  validates :idea, :user, presence: true
  validates :idea, uniqueness: { scope: :user,
                                 message: 'You are already following this idea' }

  def self.existing_favourite(idea_id, user_id)
    find_by(idea_id: idea_id, user_id: user_id)
  end
end
