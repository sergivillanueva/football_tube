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
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :nationality)
  end
end