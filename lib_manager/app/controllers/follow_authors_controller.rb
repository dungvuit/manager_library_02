class FollowAuthorsController < ApplicationController
  include CheckObject

  before_action :find_user, :find_author, :load_users, only: [:create, :destroy]

  def create
    @user.follow_author @author
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @user.unfollow_author @author
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:user_id]
    check_object @user
  end

  def find_author
    @author = Author.find_by id: (params[:author_id] || params[:id])
    check_object @author
  end

  def load_users
    @author = Author.find_by id: (params[:author_id] || params[:id])
    check_object @author
    @users = @author.follower_users.pagination params[:page]
  end
end
