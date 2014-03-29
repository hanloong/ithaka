class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments
  has_many :votes

  STATUS = [:created, :dicussing, :planned, :in_progress, :complete, :closed]
  enum status: STATUS

  validates :name, :description, :status, :project, :user, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
