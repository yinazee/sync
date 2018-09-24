class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :log_user_in #let these methods be used in views

  private
  def verify_user_is_authenticated
    redirect_to '/' unless user_is_authenticated
  end

  #check if user logged in
  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id:session[:user_id])
  end


end
