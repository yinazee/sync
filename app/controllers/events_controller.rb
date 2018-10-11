class EventsController < ApplicationController

  def index
    @events = Event.all
    @user = current_user
    @invites = @user.guest.events
  end

  def new
    @event = Event.new
    @user = current_user
    @users = User.all
  end

  def create
    @event = Event.create(params[:event])
    @event.host = current_user.host
    @user = current_user
    @users = User.all

    # @event.guest_ids = params[:event][:guest]
    if !params[:event][:guest].blank?
        params[:event][:guest].each do |id|
          #finds guests and adds them to event's guest list
          @event.guests << Guest.find_or_create_by(user_id: id)
          @event.save
          @user.host.events << @event
        end
    end
    redirect_to user_events_path
    end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @host = Host.find(@event.host_id)
  end

  def edit
    @user = current_user
    @event = Event.find_by(id: params[:id])
  end

  def update
    @user = current_user
    @event = Event.find_by(id: params[:id])
    if current_user.host.id == @event.host_id
      binding.pry
      @guests = params[:event][:guest]
      # @event.guests = @guests.each do |guest|

      @event.update(event_params)
      respond_to do |f|
      f.html {redirect_to user_event_path(@user, @event), flash: {success: "#{@event.name} was updated!"}}
    end
  else
    render :edit
  end
end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.delete
    redirect_to event_path(@event), flash: {success: "'#{@event.name}' was deleted!"}
  end

  private
  def event_params
    params.require(:event).permit(
        :name,
        :location,
        :date_from
      )
  end

end
