class User < ActiveRecord::Base
  has_many :votes
  has_many :idea
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?

  validates :name, :email, presence: true

  def set_default_role
    self.role ||= :user
  end

  def can_vote?
    votes_left > 0
  end

  def votes_left
    vote_limit - votes.count
  end

  def unlocked_votes
    votes.select { |vote| vote.unlocked? }
  end
end
