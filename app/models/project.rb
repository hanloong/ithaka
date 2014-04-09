class Project < ActiveRecord::Base
  has_many :ideas
  has_many :factors
  belongs_to :organisation
  belongs_to :user

  validates :name, :description, :organisation, presence: true

  def self.available(orgid, include_public = true)
    if include_public
      where('organisation_id = ? OR public = ?', orgid, include_public)
    else
      where(organisation_id: orgid)
    end
  end

  def manager?(u)
    u.admin? || champoin?(u) || (u.organisation == organisation && u.owner?)
  end

  def champion?(u)
    u == user
  end
end
