class Event < ActiveRecord::Base
  belongs_to :host
  has_many :event_guests
  has_many :guests, through: :event_guests

end
