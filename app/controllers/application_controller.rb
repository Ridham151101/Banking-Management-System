class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def authenticate_admin!
    if current_user.present?
      redirect_to new_user_session_path unless current_user&.has_role?(:admin)
    end
  end

  def authenticate_admin_employee!
    unless current_user&.has_role?(:admin) || current_user&.has_role?(:employee)
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end  
end
