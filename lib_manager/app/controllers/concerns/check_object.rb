module CheckObject
  def check_object params
    unless params
      flash[:danger] = t "controllers.concerns.object_not_exist"
      redirect_to root_path
    end
  end
end
