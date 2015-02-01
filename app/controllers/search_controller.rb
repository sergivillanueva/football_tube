class SearchController < ApplicationController
  before_action :check_player_search_term, only: :search_by_player
  before_action :check_team_search_term, only: :search_by_team
  before_action :check_competition_search_term, only: :search_by_competition

  def search_by_player
    @term = params[:player_name]

    if params[:player_id].present?
      @term = Player.find(params[:player_id]).name # there is no player_name param as it is a straight search by id
      @player_participations = PlayerParticipation.joins(:match).where(player_id: params[:player_id]).order("matches.playing_date").decorate  
    else
      name_where_clause = []
      full_name_where_clause = []

      words = params[:player_name].split

      words.each do |word|
        name_where_clause << "name LIKE ?"
        full_name_where_clause << "full_name LIKE ?"
      end

      where_clause = "(#{name_where_clause.join(" AND ")}) OR (#{full_name_where_clause.join(" AND ")})"
      @players = Player.where(where_clause, *(words.map{|p| "%#{p}%"} * 2)).decorate

      render :player_results
      return
    end
    
    render :search_by_player
  end
  
  def search_by_team
    @term = params[:team_name]

    if params[:team_id].present?
      @term = Team.find(params[:team_id]).name # there is no team_name param as it is a straight search by id
      @matches = Match.where("home_team_id = ? OR away_team_id = ?", params[:team_id], params[:team_id]).order("playing_date").decorate
    else
      @teams = Team.where("name like ? OR nick_names like ?", "%#{params[:team_name]}%", "%#{params[:team_name]}%").decorate
      render :team_results
      return
    end
    
    render :search_by_team
  end

  def search_by_competition
    @matches = Match.where(competition_id: params[:competition_id]).order("playing_date").decorate
  end

  private

  def check_player_search_term
    redirect_to root_path unless params[:player_id].present? || params[:player_name].present?
  end

  def check_team_search_term
    redirect_to root_path unless params[:team_id].present? || params[:team_name].present?
  end

  def check_competition_search_term
    redirect_to root_path unless params[:competition_id].present?
  end
end