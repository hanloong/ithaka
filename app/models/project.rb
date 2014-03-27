class Project < ActiveRecord::Base
  has_many :ideas
  has_many :factors
end
