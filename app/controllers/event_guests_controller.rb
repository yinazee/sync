class EventGuestsController < ApplicationController

  def update
# binding.pry
  @user = current_user
  @event = Event.find_by(id: params[:id])
     @eventguest = EventGuest.find_by(guest_id: current_user.guest.id, event_id: params[:id])
     # binding.pry
    if params[:event_guest][:rsvp].to_i == 1
      @eventguest.update(event_guest_params)
      # binding.pry
      redirect_to user_event_path(@user, @event)
    end
  end

  private

  def event_guest_params
    params.require(:event_guest).permit(:rsvp)
  end

end
