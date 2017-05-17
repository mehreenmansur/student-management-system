class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :alert => exception.message
  end

  protected
  def after_sign_in_path_for(resource)
    @user =  User.find(current_user.id)
    if @user.role == "student"
      save_register_students_path
    else
      home_admins_path
    end
  end

  # def after_sign_up_path_for(resource)
  # end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
