class CommentsController < ApplicationController
  include CheckObject

  before_action :check_book_exist, only: :create

  def create
    @comment = @book.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to book_path @book
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :user_id, :book_id
  end

  def check_book_exist
    @book = Book.find_by id: params[:book_id]
    check_object @book
  end
end
