class MatchesController < ApplicationController
  def new
    @match = Match.new
  end
    
  def create
    home_team = Team.find_or_create_by({ name: params[:match][:home_team_name] })
    away_team = Team.find_or_create_by({ name: params[:match][:away_team_name] })
    @match = Match.new match_params.merge!({ home_team: home_team, away_team: away_team })
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
    params.require(:match).permit(:home_score, :away_score, :playing_date, :home_team_name, :away_team_name)
  end
end