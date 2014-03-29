class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments
  has_many :votes

  STATUS = [:created, :dicussing, :planned, :in_progress, :complete, :closed]
  enum status: STATUS

  validates_presence_of :name, :description, :status, :project, :user
  validates_uniqueness_of :name, scope: :user_id
end
