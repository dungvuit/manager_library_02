class Admins::BorrowBooksController < ApplicationController
  layout "application_admin"
  include CheckObject

  before_action :find_book, only: [:destroy]
  before_action :find_relationship_borrow, only: [:update, :destroy]

  def index
    @borrow_books = BorrowBook.pagination params[:page]
    respond_to do |format|
      format.html
      format.xls {send_data @borrow_books.to_csv(col_sep: "\t")}
    end
  end

  def update
    if params[:status] == "borrowing"
      find_book
      if @book.amount == Settings.zero
        flash.now[:danger] = t "controller.borrow_books.flashs.danger.warning"
      else
        @borrow = @borrow_book.update_attributes status: params[:status]
        type = @borrow ? "success" : "danger"
        amount = @book.amount - Settings.borrow
        @book.update_attributes amount: amount
      end
    end
    if params[:status] == "return"
      find_book
      @borrow = @borrow_book.update_attributes status: params[:status]
      type = @borrow ? "success" : "danger"
      amount = @book.amount + Settings.borrow
      @book.update_attributes amount: amount
    end
    flash.now[:"#{type}"] = t "controllers.borrow_books.flashs.#{type}.delete"
    redirect_to admins_borrow_books_path
  end

  def destroy
    type = @borrow_book.destroy ? "success" : "danger"
    flash.now[:"#{type}"] = t "controllers.borrow_books.flashs.#{type}.deleted"
    redirect_to admins_borrow_books_path
  end

  private
  def find_relationship_borrow
    @borrow_book = BorrowBook.find_by id: params[:id]
    check_object @borrow_book
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    check_object @book
  end
end
