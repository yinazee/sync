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
    @event = Event.create(event_params)
    @event.host = current_user.host
    @users = User.all

    # @event.guest_ids = params[:event][:guest]
    if !params[:event][:guest].blank?
        params[:event][:guest].each do |id|
          #finds guests and adds them to event's guest list
          @event.guests << Guest.find_or_create_by(user_id: id)
          @event.save
        end
    end
    redirect_to events_path
    end

  def show
    @user = current_user
    @event = Event.find(params[:id])
  end

  def edit
    @user = current_user
    @users = User.all
    @event = Event.find_by(id: params[:id])
    # binding.pry
    # if !params[:event][:guest].blank?
    #     params[:event][:guest].each do |id|
    #     @event.guests << Guest.find_or_create_by(user_id: id)
    # end

    # @event.save
    # @events = @user.host.events

    # @user = Event.find_by(id: params[:host_id])
    # @event = @user.events.build(user_id: current_user.id)
    # show if checkboxes are checked
    # if params[:check].eql?('1')
  end



  def update
    @event = Event.find_by(id: params[:id])
    @event.update(event_params)
    if current_user.id == @event.host.user.id
      redirect_to event_path(@event)
    else
      redirect_to root_path, flash: {danger: "Please login to edit your event."}
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
