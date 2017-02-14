class BorrowBooksController < ApplicationController
  include CheckObject

  before_action :find_user, only: [:create, :destroy]
  before_action :find_book, only: [:create]

  def create
    @borrow = @user.borrow_books.build borrow_book_params
    if @borrow.save
      flash[:success] = t "controllers.borrow_books.flashs.success.create"
      redirect_to @user
    else
      flash[:danger] = t "controllers.borrow_books.flashs.danger.create"
      redirect_to @book
    end
  end

  def destroy
    find_relationship_borrow
    type = @book_borrow.destroy ? "success" : "danger"
    flash[:"#{type}"] = t "controllers.borrow_books.flashs.success.delete"
    redirect_to @user
  end

  private
  def borrow_book_params
    params.require(:borrow_book).permit :date_borrow, :date_return, :user_id,
      :book_id
  end

  def find_book
    @book = Book.find_by id: params[:borrow_book][:book_id]
    check_object @book
  end

  def find_relationship_borrow
    @book_borrow = @user.borrow_books.find_by id: params[:id]
    check_object @book_borrow
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    check_object @user
  end
end
