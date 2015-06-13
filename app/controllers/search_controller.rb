class SearchController < ApplicationController
  before_action :check_player_search_term, only: :search_by_player
  before_action :check_team_search_term, only: :search_by_team
  before_action :check_competition_search_term, only: :search_by_competition
  before_action :check_head_to_head_params, only: :search_head_to_head

  def advanced_search
  end

  def search_head_to_head
    ids = [params[:team_one_id], params[:team_two_id]]
    @term = params[:term].present? ? params[:term] : "#{params[:team_one_name]} vs #{params[:team_two_name]}"
    @matches = Match.where("home_team_id IN (?) AND away_team_id IN (?)", ids, ids).order("playing_date").decorate
  end

  def search_by_player
    #TODO unify param name
    @term = params[:player_name] || params[:name]

    if params[:player_id].present?
      @term = params[:term].present? ? params[:term] : Player.find(params[:player_id]).name # there is no player_name param as it is a straight search by id
      @player_participations = PlayerParticipation.joins(:match).where(player_id: params[:player_id])
      if params[:from_year].present? && params[:to_year].present?
        seasons = (params[:from_year]..params[:to_year]).to_a.map{|year| [year, "#{year}-#{year.to_i + 1}"]}.flatten.prepend("#{params[:from_year].to_i - 1}-#{params[:from_year]}" )
        @player_participations = @player_participations.where(season: seasons)
      end
      @player_participations = @player_participations.order("matches.playing_date").decorate
    else
      words = @term.split

      #http://stackoverflow.com/questions/1039512/mysql-full-text-search-in-ruby-on-rails
      @players = Player.where("MATCH(name, full_name) AGAINST (? IN BOOLEAN MODE)", words.map{|w| "+#{w}*"}.join(" "))

      if request.xhr?
        render(json: @players.to_json) && return
      else
        @players = @players.decorate
        render(:player_results) && return
      end
    end
    
    render :search_by_player
  end
  
  def search_by_team
    @term = params[:team_name]

    if params[:team_id].present?
      @term = params[:term].present? ? params[:term] : Team.find(params[:team_id]).name # there is no team_name param as it is a straight search by id
      @matches = Match.where("home_team_id = ? OR away_team_id = ?", params[:team_id], params[:team_id])
      if params[:from_year].present? && params[:to_year].present?
        seasons = (params[:from_year]..params[:to_year]).to_a.map{|year| [year, "#{year}-#{year.to_i + 1}"]}.flatten.prepend("#{params[:from_year].to_i - 1}-#{params[:from_year]}" )
        @matches = @matches.where(season: seasons)
      end
      @matches = @matches.order("playing_date").decorate
    else
      @teams = Team.where("name like ? OR nick_names like ?", "%#{params[:team_name]}%", "%#{params[:team_name]}%").decorate
      render :team_results
      return
    end
    
    render :search_by_team
  end

  def search_by_competition
    @term = Competition.find(params[:competition_id]).name
    @matches = Match.where(competition_id: params[:competition_id]).order("playing_date").decorate
  end

  private

  def check_player_search_term
    redirect_to root_path unless params[:player_id].present? || params[:player_name].present? || params[:name].present?
  end

  def check_team_search_term
    redirect_to root_path unless params[:team_id].present? || params[:team_name].present?
  end

  def check_competition_search_term
    redirect_to root_path unless params[:competition_id].present?
  end

  def check_head_to_head_params
    redirect_to(advanced_search_path, alert: t(".missing_params")) unless params[:team_one_id].present? && params[:team_two_id].present?
  end
end