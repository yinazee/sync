class EventsController < ApplicationController
  before_action :set_event, only: [:index, :show, :edit, :update, :destroy]

  def index
    @user = current_user
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
    else
      render :new, flash: {danger: "Please enter all fields."}
    end
      redirect_to user_events_path, flash: {success: "#{@event.name} is created!"}
    end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @host = Host.find(@event.host_id)
  end

  def edit
    @user = current_user
    @event = Event.find_by(id: params[:id])
    @guests = @event.guests
    @host = Host.find(@event.host_id)
    if @host.user.id != @user.id
      redirect_to user_path, flash: {danger: "Only the host is able to edit."}
    end
  end

  def update
    @user = current_user
    @event = Event.find_by(id: params[:id])

    if @event.update(event_params)
      respond_to do |f|
        f.html {redirect_to user_event_path(@user, @event), flash: {success: "#{@event.name} was updated!"}}
      end
    else
      render :edit, flash: {danger: "Please login first!"}
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.delete
    redirect_to user_events_path, flash: {success: "'#{@event.name}' was deleted!"}
  end

  private

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
