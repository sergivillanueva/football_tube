class CompetitionsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :check_admin_role, only: :index

  def search
    competitions = Competition.where("name like '%#{params[:name]}%'")
    render json: competitions.to_json
  end

  def show
    @competition = Competition.friendly.find params[:id]
    @term = @competition.name
    @matches = @competition.matches
    @matches = @matches.where(stage: params[:stage]) if params[:stage].present?
    @matches = @matches.order("playing_date").decorate
    render "search/search_by_competition"
  end
  
  def index
    @competitions = Competition.order("name")
  end
  
  def edit
    @competition = Competition.friendly.find params[:id]
  end
  
  def update
    @competition = Competition.friendly.find params[:id]
    if @competition.update_attributes(competition_params)
      redirect_to competitions_path
    else
      render :edit
    end
  end

  def new
    @competition = Competition.new
  end
  
  def create
    @competition = Competition.new competition_params
    if @competition.save
      redirect_to competitions_path
    else
      render :new
    end
  end

  def destroy
    @competition = Competition.friendly.find(params[:id])
    @competition.destroy
    redirect_to competitions_path, notice: "Competition deleted"
  end

  private
  
  def competition_params
    params.require(:competition).permit(:name, :kind, :country_id, :zone, :scope)
  end
end
