class MatchesController < ApplicationController
  def new
    @match = Match.new
  end
    
  def create
    @match = Match.new match_params
    if @match.save
      redirect_to matches_path
    else
      render :new
    end
  end
  
  def index
    @matches = Match.all
  end
  
  def show
    @match = Match.find params[:id]
  end
  
  private
  
  def match_params
    params.require(:match).permit(:home_team_id, :away_team_id, :home_score, :away_score, :playing_date, :playing_date)
  end
end