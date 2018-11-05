class Event < ApplicationRecord
  belongs_to :host
  has_many :event_guests
  has_many :guests, through: :event_guests

  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :guests, presence: true


  # 
  # def completed?
  #   if self.event_guests.rsvp == true
  #     true
  #   else
  #     false
  #   end
  # end

end
