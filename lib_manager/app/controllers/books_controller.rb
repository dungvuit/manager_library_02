class BooksController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id].present?
      find_category
      @books = @category.books.pagination params[:page]
      respond_to do |format|
        format.html
        format.js
      end
    else
      @books = Book.pagination params[:page]
    end
  end

  def show
  end

  private
  def find_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.books.category_not_exist"
      redirect_to books_path
    end
  end
end
