class Project < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Trackable

  has_many :ideas
  has_many :factors
  belongs_to :organisation
  belongs_to :user

  validates :name, :description, :organisation, presence: true

  scope :available, -> (organisation, include_public = true) {
    if include_public
      where('organisation_id = ? OR public = ?', organisation.id, include_public)
    else
      where(organisation: organisation)
    end
  }

  def has_access?(u)
    public? || u.organisation == organisation
  end

  def manager?(u)
    u.admin? || champion?(u) || (u.organisation == organisation && u.owner?)
  end

  def anonymous?
    false
  end

  def champion?(u)
    u == user
  end

  def is_public?(u)
    public? && u.organisation != organisation
  end

  def to_s
    name
  end

  def search_title
    name
  end

  def search_body
    description
  end

  def link_to
    project_path(self)
  end

  private

  def project
    self
  end
end
