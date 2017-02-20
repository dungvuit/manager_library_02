class AuthorsController < ApplicationController
  include CheckObject

  before_action :find_author, only: :show

  def show
    @books = @author.books.pagination params[:page]
    @users = @author.follower_users.pagination params[:page]
  end
  
  private
  def find_author
    @author = Author.find_by id: params[:id]
    check_object @author
  end
end
