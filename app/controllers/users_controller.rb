class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name.downcase
    @user.save
    # every user created also gets a host id and guest id
    @user.host = Host.create
    @user.guest = Guest.create

    if @user && @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully created an account!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Please enter a valid email & valid password"
      render :new #error; show user the form again
    end
  end

  def show
    # @user = User.find(current_user.id)
    redirect_to root_path unless session[:user_id] #redirect to artists pat
  end

  def destroy
    @user.destroy
    redirect_to root_path, flash: {success: "Your account has been deleted!"}
  end


private

  def set_user
    @user = User.find_by(id: params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end

end
