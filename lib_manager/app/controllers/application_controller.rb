class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "controllers.applications.please"
      redirect_to login_url
    end
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end

  def load_publishers
    @publisher = Publisher.all.collect {|publisher| [publisher.name, publisher.id]}
  end

  def load_authors
    @author = Author.all.collect {|author| [author.name, author.id]}
  end

  def load_categories
    @category = Category.all
  end

  def load_books
    @book = Book.all.collect {|book| [book.name, book.id]}
  end
end
