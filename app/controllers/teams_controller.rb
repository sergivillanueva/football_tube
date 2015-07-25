class TeamsController < ApplicationController
  before_action :authenticate_user!#, except: :search
  before_action :check_admin_role, only: :index
  #before_action :check_search_term, only: :search

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
    @team = Team.friendly.find params[:id]
  end  

  def update
    @team = Team.friendly.find params[:id]
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

  def show
    @team = Team.friendly.find params[:id]
    @term = @team.name #params[:term].present? ? params[:term] : Team.find(params[:team_id]).name # there is no team_name param as it is a straight search by id
    @matches = Match.where("home_team_id = ? OR away_team_id = ?", params[:team_id], params[:team_id])
    if params[:from_year].present? && params[:to_year].present?
      seasons = (params[:from_year]..params[:to_year]).to_a.map{|year| [year, "#{year}-#{year.to_i + 1}"]}.flatten.prepend("#{params[:from_year].to_i - 1}-#{params[:from_year]}" )
      @matches = @matches.where(season: seasons)
    end
    @matches = @matches.order("playing_date").decorate
    render "search/search_by_team"
  end

  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :logo, :country_id)
  end

  def check_search_term
    render(nothing: true) unless params[:name].present?
  end
end