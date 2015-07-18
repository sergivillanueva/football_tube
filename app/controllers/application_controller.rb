class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  #TODO use cancancan gem for this and let user crud her own stuff
  #before_action :check_admin_role, only: [:update, :edit, :destroy]

  before_action :set_competitions

  def set_competitions
    competitions = Competition.completed.group_by(&:scope)

    @national_teams_competitions = competitions["national_teams"].group_by(&:zone) if competitions["national_teams"].present?
    @international_competitions = competitions["international"].group_by(&:zone) if competitions["international"].present?
    @domestic_competitions = competitions["domestic"].group_by(&:zone) if competitions["domestic"].present?
    @friendly = competitions["friendly"] if competitions["friendly"].present?
  end

  private

  def check_admin_role
  	redirect_to root_path, alert: t("not_authorized") unless user_signed_in? && current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:avatar, :country_id, :nick_name]
  end
end
