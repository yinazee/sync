class EventGuest < ApplicationRecord
  belongs_to :event
  belongs_to :guest

  scope :rsvp, -> { where(rsvp: true) }


end
