class EventGuests < ApplicationController

  def update
    
    @eventguest = @eventguest = EventGuest.find_by(guest_id: current_user.guest.id, event_id: params[:id])
    if !params[:rsvp].blank?
      @eventguest.update(:rsvp)
    end
  end

end
