class Admins::PublishersController < ApplicationController
  layout "application_admin"

  before_action :logged_in_user, :verify_admin
  before_action :find_user, except: [:index, :new, :create]

  def index
    @publishers = Publisher.sort_by_create_at.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.xls {send_data @publishers.to_csv(col_sep: "\t")}
    end
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "controllers.publishers.publisher_create"
      redirect_to admins_publishers_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      redirect_to admins_publishers_path
      flash[:success] = t "controllers.publishers.publisher_edit"
    else
      render :edit
    end
  end

  def destroy
    @publisher.destroy
    flash[:success] = t "controllers.publishers.publisher_delete"
    redirect_to admins_publishers_path 
  end

  private
  def find_user
    @publisher = Publisher.find_by id: params[:id]
    unless @publisher
      flash[:danger] = t "controllers.publishers.publisher_not_exist"
      redirect_to admins_publishers_path
    end
  end

  def publisher_params
    params.require(:publisher).permit :name, :address, :phone,
      :description
  end
end
