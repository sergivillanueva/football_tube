class SearchController < ApplicationController
  def search_by_player
    if params[:player_id].present?
      @player_participations = PlayerParticipation.joins(:match).where(player_id: params[:player_id]).order("matches.playing_date").decorate  
    else
      name_where_clause = []
      full_name_where_clause = []

      params[:player_name].split.each do |word|
        name_where_clause << "name LIKE '%#{word}%'"
        full_name_where_clause << "full_name LIKE '%#{word}%'"
      end

      where_clause = "(#{name_where_clause.join(" AND ")}) OR (#{full_name_where_clause.join(" AND ")})"

      @players = Player.where(where_clause).decorate
      render :player_results
      return
    end
    
    render :search_by_player
  end
  
  def search_by_team
    if params[:team_id].present?
      @matches = Match.where("home_team_id = #{params[:team_id]} OR away_team_id = #{params[:team_id]}").order("playing_date").decorate  
    else
      @teams = Team.where("name like '%#{params[:team_name]}%' OR nick_names like '%#{params[:team_name]}%'").decorate
      render :team_results
      return
    end
    
    render :search_by_team
  end

  def search_by_competition
    @matches = Match.where("competition_id = #{params[:competition_id]}").order("playing_date").decorate
  end
end