class FollowAuthorsController < ApplicationController
  include CheckObject

  before_action :find_user, only: [:create, :destroy]
  before_action :find_author, only: [:create, :destroy]

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
end
