class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if auth
      @user = User.set_user_from_omniauth(auth['uid'])
      log_user_in
      redirect_to user_path(@user), flash: {success: "You're logged in through Facebook!"} #user_path(@user)
    else
      @user = User.find_by(name: params[:user][:name])
      session[:user_id] = @user.id
        if @user && @user.authenticate(params[:user][:password])
          log_user_in
          redirect_to root_path, flash: {success: "You're logged in!"}  #user_path(@user)
        else
          redirect_to '/sessions/new', flash: {danger: "Invalid email/password combination!"}
        end
     end
   end


  def destroy
    session.delete :user_id
    redirect_to root_path, flash: {success: "You're logged out!"}
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
