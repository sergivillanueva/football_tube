class TeamsController < ApplicationController
  before_action :authenticate_user!, except: :search

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

  def edit
    @team = Team.find params[:id]
  end  

  def update
    @team = Team.find params[:id]
    if @team.update_attributes(team_params)
      redirect_to teams_path
    else
      render :edit
    end
  end

  def index    
    respond_to do |format|
      format.html
      format.json do
        @teams = Team.includes(:country)
        render "teams/index"
      end
    end
  end
  
  def search
    teams = Team.where("name like '%#{params[:name]}%' OR nick_names like '%#{params[:name]}%'")
    render json: teams.to_json
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :logo, :country_id)
  end
end