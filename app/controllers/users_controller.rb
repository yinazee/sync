class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.host = Host.create
    @user.guest = Guest.create

    if @user && @user.save
       @user.id = session[:user_id]
      flash[:success] = "You've successfully created an account!"
      edirect_to user_path(@user)
      # redirect_to @user #/users/#{@user.id} same as user_path(@user)
    else
      flash.now[:danger] = "Please enter a valid email & valid password"
      render :new #error; show user the form again
    end
    # return render :new unless @user.save
    #
    # session[:user_id] = @user.id
    # redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    current_user ? (render :show) : (redirect_to root_path)
  end

  def delete
    @user.destroy
  redirect_to root_path, flash: {success: "Your account has been deleted!"}
  end


private

  def set_user
    @user = User.find_by(id: params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

end
