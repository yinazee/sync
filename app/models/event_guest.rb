class EventGuest < ActiveRecord::Base
  belongs_to :event
  belongs_to :guest
end
