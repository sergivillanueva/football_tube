class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_competitions

  after_filter :store_location
  before_action :set_locale

  def set_competitions
    competitions = Competition.completed.group_by(&:scope)

    @national_teams_competitions = competitions["national_teams"].group_by(&:zone) if competitions["national_teams"].present?
    @international_competitions = competitions["international"].group_by(&:zone) if competitions["international"].present?
    @domestic_competitions = competitions["domestic"].group_by(&:zone) if competitions["domestic"].present?
    @friendly = competitions["friendly"] if competitions["friendly"].present?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  private

  def check_admin_role
  	redirect_to root_path, alert: t("not_authorized") unless user_signed_in? && current_user.admin?
  end

  def mobile?  
    request.user_agent =~ /Mobile|webOS/  
  end 

  helper_method :mobile?

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
	!request.path.end_with?("preview_image") &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:avatar, :country_id, :nick_name, :favourite_team_id]
  end
end
