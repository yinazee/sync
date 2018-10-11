class SessionsController < ApplicationController
  def new
    @user = User.new
    @user.host_id = Host .new
    @user.guest_id = Guest.new
  end

  def create
    if auth
      @user = User.set_user_from_omniauth(auth['uid'])
      log_user_in
      redirect_to artists_path(@user), flash: {success: "You're logged in through Facebook!"} #user_path(@user)
    else
      #find user by name
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        log_user_in
        redirect_to root_path, flash: {success: "You're logged in!"}  #user_path(@user)
      else
        redirect_to '/sessions/new', flash: {danger: "Invalid email/password combination!"}
      end
    end
  end

  # def create
  #   if params[:user][:name]
  #     @user = User.find_by(name: params[:user][:name])
  #     @user.try(:authenticate, params[:password])
  #   else
  #     @user = User.find_or_create_by(uid: auth['uid']) do |u|
  #       u.name = auth['info']['name']
  #       u.email = auth['info']['email']
  #       u.image = auth['info']['image']
  #   end
  # end
  #   session[:user_id] = @user.id
  #   render 'welcome/home'
  # end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
