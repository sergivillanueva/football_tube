class PlayersController < ApplicationController
  before_filter :check_uncompleted_param, only: :index
  before_action :authenticate_user!, except: :search

  def search
    name_where_clause = []
    full_name_where_clause = []
    
    params[:name].split.each do |word|
      name_where_clause << "name LIKE '%#{word}%'"
      full_name_where_clause << "full_name LIKE '%#{word}%'"
    end
    
    where_clause = "(#{name_where_clause.join(" AND ")}) OR (#{full_name_where_clause.join(" AND ")})"
    
    players = Player.where(where_clause)
    render json: players.to_json
  end
  
  def index
    respond_to do |format|
      format.html
      format.json do
        @players = @only_uncompleted ? Player.uncompleted.includes(:country) : Player.includes(:country).all
        render "players/index"
      end
    end
  end
  
  def edit
    @player = Player.find params[:id]
  end
  
  def update
    @player = Player.find params[:id]
    if @player.update_attributes(player_params)
      redirect_to players_path
    else
      render :edit
    end
  end
  
  private
  
  def player_params
    params.require(:player).permit(:full_name, :name, :country_id, :birthday)
  end

  def check_uncompleted_param
    @only_uncompleted = true
    @only_uncompleted = false if !params[:uncompleted].nil? && params[:uncompleted] == "0"
  end
end
