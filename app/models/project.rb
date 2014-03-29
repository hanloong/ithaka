class Project < ActiveRecord::Base
  has_many :ideas
  has_many :factors

  validates :name, :description, presence: true
end
