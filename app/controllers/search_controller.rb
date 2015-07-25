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

    words = @term.split
    words_for_full_text_search = words.map{|w| "+#{w}*"}.join(" ")

    #http://stackoverflow.com/questions/1039512/mysql-full-text-search-in-ruby-on-rails
    @players = Player.where("MATCH(name, full_name) AGAINST (? IN BOOLEAN MODE)", words_for_full_text_search)

    if request.xhr?
      render(json: @players.to_json) && return
    else
      #Don't bother user if there is 1 result: go straight to this one
      if @players.size == 1
        redirect_to @players.first
        return
      else
        @players = @players.decorate
        render(:player_results) && return
      end
    end
    
    #render :search_by_player
  end
  
  def search_by_team
    #TODO unify param name
    @term = params[:team_name] || params[:name]
    
    #TODO use full text search like on players  
    @teams = Team.where("name like ? OR nick_names like ?", "%#{@term}%", "%#{@term}%")

    if request.xhr?
      render(json: @teams.to_json) && return
    else
      #Don't bother user if there is 1 result: go straight to this one
      if @teams.size == 1
        redirect_to @teams.first
        return
      else
        @teams = @teams.decorate
        render(:team_results) && return
      end
    end
    
    #render :search_by_team
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
    redirect_to root_path unless params[:team_id].present? || params[:team_name].present? || params[:name].present?
  end

  def check_competition_search_term
    redirect_to root_path unless params[:competition_id].present?
  end

  def check_head_to_head_params
    redirect_to(advanced_search_path, alert: t(".missing_params")) unless params[:team_one_id].present? && params[:team_two_id].present?
  end
end