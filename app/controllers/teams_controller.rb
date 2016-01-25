class TeamsController < ApplicationController
  before_action :authenticate_user!, except: :show
  #TODO use cancancan gem for this and let user crud her own stuff
  before_action :check_admin_role, only: [:update, :edit, :destroy, :index]

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
    @term = params[:term] && params[:term].sub(" football matches", "") || @team.name
    @matches = Match.published.where("home_team_id = ? OR away_team_id = ?", @team.id, @team.id) #TODO find a better way to to this
    if params[:from_year].present? && params[:to_year].present?
      seasons = (params[:from_year]..params[:to_year]).to_a.map{|year| [year, "#{year}-#{year.to_i + 1}"]}.flatten.prepend("#{params[:from_year].to_i - 1}-#{params[:from_year]}" )
      @matches = @matches.where(season: seasons)
    end
    @matches = @matches.order("playing_date").paginate(:per_page => 20, :page => params[:page]).decorate
    render "search/search_by_team"
  end

  def destroy
    @team = Team.friendly.find params[:id]
    @team.destroy
    redirect_to teams_path, notice: "Team deleted"
  rescue Exception => e
    redirect_to teams_path, alert: "Team cannot be deleted: #{e}"
  end

  private
  
  def team_params
    params.require(:team).permit(:name, :nick_names, :logo, :country_id)
  end

end
