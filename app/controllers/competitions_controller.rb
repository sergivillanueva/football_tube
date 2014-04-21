class CompetitionsController < ApplicationController
  before_action :authenticate_user!

  def search
    competitions = Competition.where("name like '%#{params[:name]}%'")
    render json: competitions.to_json
  end
  
  def index
    @competitions = Competition.order("name")
  end
  
  def edit
    @competition = Competition.find params[:id]
  end
  
  def update
    @competition = Competition.find params[:id]
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
    @competition = Competition.find(params[:id])
    @competition.destroy
    redirect_to competitions_path, notice: "Competition deleted"
  end

  private
  
  def competition_params
    params.require(:competition).permit(:name, :kind, :country_id)
  end
end