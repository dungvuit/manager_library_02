class FollowBooksController < ApplicationController
  include CheckObject

  before_action :find_user, only: [:create, :destroy]
  before_action :find_book, only: [:create, :destroy]

  def create
    @user.follow_book @book
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @user.unfollow_book @book
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

  def find_book
    @book = Book.find_by id: (params[:book_id] || params[:id])
    check_object @book
  end
end
