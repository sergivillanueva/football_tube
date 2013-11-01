class TeamsController < ApplicationController
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new team_params
    if @team.save
      redirect_to teams_path
    else
      render :new
    end
  end
  
  def index
    @teams = Team.all
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :country_code, :logo)
  end
end