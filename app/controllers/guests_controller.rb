class GuestsController < ApplicationController

  def show
    @guests = @event.event_guests
    @invites = @user.guest.events
    @guest = Guest.find(@user.id)
    @eventguest = EventGuest.find_by(guest_id: current_user.guest.id, event_id: params[:id])

  end

end
