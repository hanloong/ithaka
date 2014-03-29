class Project < ActiveRecord::Base
  has_many :ideas
  has_many :factors

  validates_presence_of :name, :description
end
