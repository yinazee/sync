class EventsController < ApplicationController
  before_action :set_event, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_host, only: [:show, :edit]

  def index
    @events = @user.host.events
    @invites = @user.guest.events
  end

  def new
    @event = Event.new
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
            @user.host.events << @event
          end
          redirect_to user_events_path, flash: {success: "#{@event.name} is created!"}
      else
        render :new, flash: {danger: "Please enter all fields."}
      end
        # redirect_to user_events_path, flash: {success: "#{@event.name} is created!"}
      end

  def show
  end

  def edit
    @guests = @event.guests
    if @host.user.id != @user.id
      redirect_to user_path, flash: {danger: "Only the host is able to edit."}
    end
  end

  def update
    if @event.update(event_params)
      redirect_to user_event_path(@user, @event), flash: {success: "#{@event.name} was updated!"}
    else
      render :edit, flash: {danger: "Please login first!"}
    end
  end

  def destroy
    @event.event_guests.destroy_all
    @event.delete
    redirect_to user_events_path, flash: {success: "'#{@event.name}' was deleted!"}
  end

  private

  def set_host
    @host = Host.find(@event.host_id)
  end

  def set_user
    @user = current_user
  end

  def set_event
    @event = Event.find_by(id: params[:id])
  end

  def event_params
    params.require(:event).permit(
        :name,
        :location,
        :date,
        :description,
        :guests
      )
  end

end
