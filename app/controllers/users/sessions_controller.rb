# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :pending_approval?, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def pending_approval?
    user = User.find_by_email(params[:user][:email])
    
    if user && user.has_role?(:customer) && user.account_request && user.account_request.status == 'pending'
      flash[:alert] = 'Your account creation request is still pending approval. Please try again later.'
      redirect_to new_user_session_path
    end
  end
end
