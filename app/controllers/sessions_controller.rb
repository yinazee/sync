class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:user][:name]
      @user = User.find_by(name: params[:user][:name])
      @user.try(:authenticate, params[:password])
    else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
    end
  end
    session[:user_id] = @user.id
    render 'welcome/home'
  end

  def destroy
  session.delete :user_id
  redirect_to root_path
end

  private

  def auth
    request.env['omniauth.auth']
  end
end
