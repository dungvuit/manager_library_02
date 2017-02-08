class UsersController < ApplicationController
  before_action :find_user, only: :show

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.users.create_success"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :name, :address, :phonenumber
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controllers.users.user_not_exist"
      redirect_to users_path
    end
  end
end
