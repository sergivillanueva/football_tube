class MatchesController < ApplicationController
  decorates_assigned :match

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
    # Assign teams
    home_team = Team.find_or_create_by({ name: params[:match][:home_team_name] })
    away_team = Team.find_or_create_by({ name: params[:match][:away_team_name] })
    
    # Assign competition
    competition = Competition.find_or_create_by({ name: params[:match][:competition_name] })
    
    # Assign player and secure side and role attributes for players
    players_attributes.each do |attributes|
      params[:match][attributes[:key]].each do |player_participation|
        #Find player or create a new one
        player_id = player_participation[1][:player_id]
        player_id = Player.create({ name: player_participation[1][:player_name] }).id unless player_id.present?
        
        player_participation[1].merge!({ player_id: player_id, side: attributes[:side], role: attributes[:role] })
        match_params.merge!(Hash.new(key: player_participation[0], value: player_participation[1]))
      end
    end
    
    # Assign player and secure side and role attributes for coaches
    coaches_attributes.each do |attributes|
      player_participation = params[:match][attributes[:key]]

      #Find player or create a new one      
      player_id = player_participation[:player_id]
      player_id = Player.create({ name: player_participation[:player_name] }).id unless player_id.present?
      
      player_participation.merge!({ player_id: player_id, side: attributes[:side], role: attributes[:role] })
      match_params.merge!(Hash.new(key: attributes[:key], value: player_participation))
    end
    
    @match = Match.new match_params.merge({ 
      home_team_id: home_team.id, 
      away_team_id: away_team.id,
      competition_id: competition.id
    })
    
    if @match.save
      redirect_to matches_path
    else
      render :new
    end
  end
  
  def index
    @matches = Match.order(:playing_date).decorate
  end
  
  def show
    @match = Match.find(params[:id])
    @related_matches = @match.related_matches
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_path, notice: "Match deleted"
  end
  
  private
  
  def match_params
    params.require(:match).permit(
      :home_score, 
      :away_score, 
      :playing_date, 
      :home_team_name, 
      :away_team_name,
      :home_team_id,
      :away_team_id,
      :competition_name,
      :language,
      home_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_coach_attributes: [:player_name, :side, :player_id, :role, :new_player],
      away_coach_attributes: [:player_name, :side, :player_id, :role, :new_player]
    )
  end
  
  def players_attributes
    [ { key: "home_starters_attributes", side: "home", role: "starter" },
      { key: "home_reserves_attributes", side: "home", role: "reserve" },
      { key: "away_starters_attributes", side: "away", role: "starter" },
      { key: "away_reserves_attributes", side: "away", role: "reserve" } ]
  end
  
  def coaches_attributes
    [ { key: "home_coach_attributes", side: "home", role: "coach" },
      { key: "away_coach_attributes", side: "away", role: "coach" } ]
  end
end
