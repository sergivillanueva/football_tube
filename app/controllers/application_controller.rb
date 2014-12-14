class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  #TODO use cancancan gem for this and let user crud her own stuff
  before_action :check_user, only: [:update, :edit, :destroy]

  private

  def check_user
  	redirect_to root_path unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:avatar, :country_id, :nick_name]
  end
end
