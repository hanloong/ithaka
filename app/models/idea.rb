class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments
  has_many :votes
end
