class TeamsController < ApplicationController
  before_action :authenticate_user!, except: :search
  before_action :check_search_term, only: :search

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

  #TODO move this to search controller and use full text search like on players  
  def search
    teams = Team.where("name like ? OR nick_names like ?", "%#{params[:name]}%", "%#{params[:name]}%")
    render json: teams.to_json
  end
  
  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :logo, :country_id)
  end

  def check_search_term
    render(nothing: true) unless params[:name].present?
  end
end