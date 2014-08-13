class User < ActiveRecord::Base
  has_many :votes
  has_many :ideas
  has_many :comments
  has_many :projects
  has_many :favourites
  belongs_to :organisation

  accepts_nested_attributes_for :organisation

  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  enum role: [:user, :owner, :admin]
  after_initialize :set_default_role, if: :new_record?
  attr_reader :avatar_url

  validates :name, :email, :organisation, presence: true
  @avatar_url = nil

  before_create :set_default_role
  after_create :welcome_email

  delegate :name, to: :organisation, prefix: true
  delegate :vote_limit, to: :organisation, prefix: false

  scope :org_owners, -> (org_id) {
    where(organisation_id: org_id).select do |u|
      %w(admin owner).include?(u.role)
    end
  }

  def self.from_omniauth(auth)
    if user = find_by(email: auth.info.email)
      if user.uid != auth.uid
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name if user.name.empty?
        user.save
      end
      user
    end
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

  def set_default_role
    self.role ||= :owner
  end

  def welcome_email
    UserMailer.delay.welcome_email(self)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
