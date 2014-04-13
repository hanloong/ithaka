class User < ActiveRecord::Base
  has_many :votes
  has_many :idea
  has_many :comments
  has_many :projects
  has_many :favourites
  belongs_to :organisation

  accepts_nested_attributes_for :organisation

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :owner, :admin]
  after_initialize :set_default_role, if: :new_record?

  validates :name, :email, :organisation, presence: true
  attr_reader :avatar_url
  @avatar_url = nil

  delegate :name, to: :organisation, prefix: true

  def self.org_owners(org_id)
    where(organisation_id: org_id).select do |u|
      %w(admin owner).include?(u.role)
    end
  end

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
