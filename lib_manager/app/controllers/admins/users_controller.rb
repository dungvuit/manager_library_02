class Admins::UsersController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controllers.users.admin_create_user"
      redirect_to admins_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      redirect_to admins_users_path
      flash[:success] = t "controllers.users.edit_user_success"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "controllers.users.admin_delete"
    redirect_to admins_users_path 
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controllers.users.user_not_exist"
      redirect_to admins_users_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :phonenumber, :is_admin
  end
end
