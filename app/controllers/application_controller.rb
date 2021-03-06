class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan:: AccessDenied do |exception|
    redirect_to guarantees_url, :alert => exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :username, :about, :email, :password, :avatar, :current_password, :remember_me) }
  end
end
