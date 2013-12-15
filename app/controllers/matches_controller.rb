class MatchesController < ApplicationController
  def new
    @match = Match.new
    11.times do
      @match.home_starters.build({ side: "home", role: "starter" }) #TODO check if params are needed
      @match.away_starters.build({ side: "away", role: "starter" })
    end
    6.times do
      @match.home_reserves.build({ side: "home", role: "reserve" })
      @match.away_reserves.build({ side: "away", role: "reserve" })
    end
    @match.build_home_coach
    @match.build_away_coach
  end
    
  def create
    home_team = Team.find_or_create_by({ name: params[:match][:home_team_name] })
    away_team = Team.find_or_create_by({ name: params[:match][:away_team_name] })
    
    %w(home_starters_attributes home_reserves_attributes away_starters_attributes away_reserves_attributes).each do |attributes|
      params[:match][attributes].each do |player_participation|
        player = Player.find_or_create_by({ name: player_participation[1][:player_name] })
        player_participation[1].merge!({ player_id: player.id })
        match_params.merge!(Hash.new(key: player_participation[0], value: player_participation[1]))
      end
    end
    
    %w(home_coach_attributes away_coach_attributes).each do |attributes|
      player_participation = params[:match][attributes]
      player = Player.find_or_create_by({ name: player_participation[:player_name] })
      player_participation.merge!({ player_id: player.id })
      match_params.merge!(Hash.new(key: attributes, value: player_participation))
    end
    
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
    params.require(:match).permit(
      :home_score, 
      :away_score, 
      :playing_date, 
      :home_team_name, 
      :away_team_name, 
      home_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_coach_attributes: [:player_name, :side, :player_id, :role],
      away_coach_attributes: [:player_name, :side, :player_id, :role]
    )
  end
end