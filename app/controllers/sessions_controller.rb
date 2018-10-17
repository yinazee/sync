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
      @user = User.find_by(name: params[:user][:name].downcase)
      if @user.try(:authenticate, params[:user][:password])
        render :new unless @user
        log_user_in
        redirect_to root_path, flash: {success: "You're logged in!"}
      else
        redirect_to '/login', flash: {danger: "Invalid email/password combination!"}
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
