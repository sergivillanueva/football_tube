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
  
  def search
    teams = Team.where("name like '%#{params[:name]}%'")
    render json: teams.to_json
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :logo, :country_id)
  end
end