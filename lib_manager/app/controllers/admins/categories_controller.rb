class Admins::CategoriesController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_category, except: [:index, :new, :create]
  before_action :load_data, only: [:new, :edit]

  def index
    @categories = if params[:search].present?
      Category.search_by_name(params[:search])
    else
      Category
    end.sort_by_create_at.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.js
      format.xls {send_data @categories.to_csv(col_sep: "\t")}
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.categories.category_create"
      redirect_to admins_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      redirect_to admins_categories_path
      flash[:success] = t "controllers.categories.category_edit"
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controllers.categories.category_delete"
    else
      flash[:danger] = t "controllers.categories.wrong_category"
    end
    redirect_to admins_categories_path 
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "controllers.books.category_not_exist"
      redirect_to admins_categories_path
    end
  end

  def category_params
    params.require(:category).permit :name, :book_ids
  end

  def load_data
    @supports = Supports::Relationship.new
  end
end
