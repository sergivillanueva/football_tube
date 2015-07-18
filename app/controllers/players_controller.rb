class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role, on: :index  
  before_filter :check_uncompleted_param, only: :index

  def index
    respond_to do |format|
      format.html
      format.json do
        @players = @only_uncompleted ? Player.uncompleted.includes(:country) : Player.includes(:country)
        render "players/index"
      end
    end
  end
  
  def edit
    @player = Player.friendly.find params[:id]
  end
  
  def update
    @player = Player.friendly.find params[:id]
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
