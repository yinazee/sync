class Event < ApplicationRecord
  belongs_to :host
  has_many :event_guests
  has_many :guests, through: :event_guests

  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :guests, presence: true

  scope :date_order, -> { order(date: :desc) }


  # def event_order
  #   current_user.host.events.order('date DESC, date')
  # end

end
