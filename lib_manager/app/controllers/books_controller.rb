class BooksController < ApplicationController
  include CheckObject

  before_action :check_book_exist, only: :show

  def index
    @categories = Category.all
    if params[:category_id].present?
      find_category
      @books = @category.books.pagination params[:page]
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
end
