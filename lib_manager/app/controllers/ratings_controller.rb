class RatingsController < ApplicationController
  include CheckObject

  before_action :find_user, :find_book, only: [:create, :update]
  before_action :user_rating, only: :update

  def create
    rate = @user.ratings.build rating_params
    type = rate.save ? "success" : "danger"
    flash[:"#{type}"] = t "controllers.rating.flashs.success.create"
    redirect_to @book
  end

  def update
    ratings = @user_rating.update_attributes rating_params
    type = ratings ? "success" : "danger"
    flash[:"#{type}"] = t "controllers.rating.flashs.success.update"
    redirect_to @book
  end

  private
  def rating_params
    params.require(:rating).permit :book_id, :rate
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    check_object @user
  end

  def find_book
    @book = Book.find_by id: params[:rating][:book_id]
    check_object @book
  end

  def user_rating
    @user_rating = current_user.ratings.find_by book_id: params[:rating][:book_id]
    check_object @user_rating
  end
end
