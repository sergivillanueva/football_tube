class PagesController < ApplicationController
  
  def home
    competitions = Competition.completed.group_by(&:scope)

    @national_teams_competitions = competitions["national_teams"].group_by(&:zone) if competitions["national_teams"].present?
    @international_competitions = competitions["international"].group_by(&:zone) if competitions["international"].present?
    @domestic_competitions = competitions["domestic"].group_by(&:zone) if competitions["domestic"].present?
  end
      
end