class Guest < ActiveRecord::Base
  belongs_to :user
  
  has_many :event_guests
  has_many :events, through: :event_guests

  has_many :hosts, through: :events

end
