class UsersController < ApplicationController
  include CheckObject

  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :check_user_exist, only: [:show, :edit, :update]

  def show
    @users = @user.following.pagination params[:page]
    @borrow_books = @user.borrow_books
    @following_books = @user.books
    if params[:relationship].present?
      @users = if params[:relationship] == "following"
        @user.following.pagination params[:page]
      elsif params[:relationship] == "followers"
        @user.followers.pagination params[:page]
      end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.users.create_success"
      redirect_back_or @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.users.edit_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :image, :address, :phonenumber
  end

  def check_user_exist
    @user = User.find_by id: params[:id]
    check_object @user
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.current_user? @user
  end
end
