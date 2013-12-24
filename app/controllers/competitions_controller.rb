class CompetitionsController < ApplicationController
  def search
    competitions = Competition.where("name like '%#{params[:name]}%'")
    render json: competitions.to_json
  end
  
  private
  
  def competition_params
    params.require(:competition).permit(:name)
  end
end