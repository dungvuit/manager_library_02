class FollowUsersController < ApplicationController
  include CheckObject

  before_action :find_user, only: [:index, :create, :destroy]

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
end
