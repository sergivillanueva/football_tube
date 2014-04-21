class PlayersController < ApplicationController
  before_filter :check_uncompleted_param, only: :index
  before_action :authenticate_user!, except: :search

  def search
    players = Player.where("name like '%#{params[:name]}%' OR full_name like '%#{params[:name]}%'")
    render json: players.to_json
  end
  
  def index
    if @only_uncompleted == true
      @players = Player.uncompleted.order("name").paginate(:page => params[:page], :per_page => 500)
    else
      @players = Player.order("name").paginate(:page => params[:page], :per_page => 500)
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
