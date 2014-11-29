module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :trackable
    after_create :track_action
  end

  private

  def track_action(message = nil)
    Event.create!(
      project: project,
      user: user,
      message: message,
      trackable: self
    )
  end
end
