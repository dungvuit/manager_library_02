class Admins::BooksController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_book, except: [:index, :new, :create]

  def index
    @books = Book.paginate page: params[:page]
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
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      redirect_to admins_books_path
      flash[:success] = t "controllers.books.book_edit"
    else
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
      :weight, :language, :description, :rating, :publisher_id
  end
end
