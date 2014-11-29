class Event < ActiveRecord::Base
  belongs_to :project, touch: true
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  scope :recent_for, ->(user) do
    joins(:project).
    where('project.organisation_id = ? || project.public = TRUE', user.organisation_id).order(id: :desc)
  end

  PER_PAGE = 10
  scope :paginate, ->(current_page=1) do
    current_page = (current_page.to_i || 1)
    page(current_page).per(PER_PAGE)
  end

end
