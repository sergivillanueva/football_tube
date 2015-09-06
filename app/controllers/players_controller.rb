class PlayersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_filter :check_uncompleted_param, only: :index
  #TODO use cancancan gem for this and let user crud her own stuff
  before_action :check_admin_role, only: [:update, :edit, :destroy, :index]

  def index
    respond_to do |format|
      format.html
      format.json do
        @players = @only_uncompleted ? Player.uncompleted.includes(:country) : Player.includes(:country)
        render "players/index"
      end
    end
  end

  def show
    @player = Player.friendly.find params[:id]
    @term = @player.name
    @player_participations = @player.player_participations.joins(:match).where(:"matches.published" => true) #PlayerParticipation.joins(:match).where(player_id: params[:player_id])
    if params[:from_year].present? && params[:to_year].present?
      seasons = (params[:from_year]..params[:to_year]).to_a.map{|year| [year, "#{year}-#{year.to_i + 1}"]}.flatten.prepend("#{params[:from_year].to_i - 1}-#{params[:from_year]}" )
      @player_participations = @player_participations.where(season: seasons)
    end
    @player_participations = @player_participations.order("matches.playing_date").decorate
    render "search/search_by_player"
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
  
  def destroy
    @player = Player.friendly.find(params[:id])
    @player.destroy
    redirect_to players_path, notice: "Player deleted"
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
