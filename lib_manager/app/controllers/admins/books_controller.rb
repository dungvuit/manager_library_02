class Admins::BooksController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_book, except: [:index, :new, :create]
  before_action :load_data, only: [:index, :new, :edit]

  def index
    @books = if params[:category_id].present?
      Category.find_by(id: params[:category_id]).books
    else
      Book
    end.sort_by_create_at.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.js
      format.xls {send_data @books.to_csv(col_sep: "\t")}
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "controllers.books.book_create"
      redirect_to admins_books_path
    else
      load_data
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      redirect_to admins_books_path
      flash[:success] = t "controllers.books.book_edit"
    else
      load_data
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:success] = t "controllers.books.book_delete"
    redirect_to admins_books_path 
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "controllers.books.category_not_exist"
      redirect_to admins_books_path
    end
  end

  def book_params
    params.require(:book).permit :name, :image, :publisher_year, :amount,
      :weight, :language, :description, :rating, :publisher_id, :author_ids,
      :category_ids
  end

  def load_data
    @supports = Supports::Relationship.new
  end
end
