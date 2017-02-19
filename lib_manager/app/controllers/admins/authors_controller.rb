class Admins::AuthorsController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_author, except: [:index, :new, :create]
  before_action :load_author_genders, only: [:new, :edit]
  before_action :load_publishers, only: [:new, :edit]

  def index
    @authors = Author.sort_by_create_at.paginate page: params[:page]
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t "controllers.authors.author_create"
      redirect_to admins_author_path(@author)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @author.update_attributes author_params
      redirect_to admins_author_path(@author)
      flash[:success] = t "controllers.authors.author_edit"
    else
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "controllers.authors.author_delete"
    else
      flash[:danger] = t "controllers.authors.wrong_author"
    end
    redirect_to admins_authors_path 
  end

  private
  def load_author_genders
    @gender = Author.genders.keys
  end

  def find_author
    @author = Author.find_by id: params[:id]
    unless @author
      flash[:danger] = t "controllers.authors.author_not_exist"
      redirect_to admins_authors_path
    end
  end

  def author_params
    params.require(:author).permit :name, :gender, :address,
      :description, :publisher_id, :image
  end
end
