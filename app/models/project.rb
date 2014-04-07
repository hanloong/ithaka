class Project < ActiveRecord::Base
  has_many :ideas
  has_many :factors
  belongs_to :organisation

  validates :name, :description, :organisation, presence: true

  default_scope { where(public: true) }

  def self.available(organisation_id, include_public = true)
    where(' organisation_id = ? OR public = ? ',organisation_id, include_public)
  end
end
