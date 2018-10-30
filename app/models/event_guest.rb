class EventGuest < ActiveRecord::Base
  belongs_to :event
  belongs_to :guest

  def going?
    self.rsvp == true
  end

  def not_going?
    self.rsvp == false
  end
end
