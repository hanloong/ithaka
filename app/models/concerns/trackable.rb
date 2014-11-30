module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :trackable
    after_create :track_create_event
    after_update :track_update_event
  end

  private

  def track_event(message = nil)
    Event.create!(
      project: project,
      user: user,
      message: message,
      trackable: self
    )
  end

  def track_create_event
    track_event "#{self.class.name}: #{name} created."
  end

  def track_update_event
    if track_update_message
      track_event track_update_message
    end
  end

  def track_update_message
    nil
  end
end
