class FollowUsersController < ApplicationController
  include CheckObject

  before_action :find_user, :load_user_following, only: [ :create, :destroy]

  def create
    current_user.following_user @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    current_user.unfollow_user @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def find_user
    @user = User.find_by id: (params[:follower_id] || params[:id] || params[:user_id])
    check_object @user
  end

  def load_user_following
    @users = current_user.following.pagination params[:page]
  end
end
