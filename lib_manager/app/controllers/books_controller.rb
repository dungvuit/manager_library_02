class BooksController < ApplicationController
  include CheckObject

  before_action :check_book_exist, :user_rating, only: :show

  def index
    @categories = Category.all
    if params[:category_id].present?
      find_category
      @books = @category.books.pagination params[:page]
    elsif params[:search].present?
      search_book
      @books = @books.pagination params[:page]
    else
      @books = Book.pagination params[:page]
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comments = @book.comments.sort_by_create_at
  end

  private
  def check_book_exist
    @book = Book.find_by id: params[:id]
    check_object @book
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    check_object @category
  end

  def search_book
    @books = Book.all
    if params[:search].present?
      @books = @books.search_book params[:search][:book_name], params[:search][:author_name],
        params[:search][:category_name], params[:search][:publisher_name]
    end
  end

  def user_rating
    @user_rating = current_user.ratings.find_by book_id: params[:id] if logged_in?
  end
end
