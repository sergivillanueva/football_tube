class SearchController < ApplicationController
  def search_by_player
    @player_name = params[:player_name]
    if params[:player_id].present?
      @player_participations = PlayerParticipation.where(player_id: params[:player_id]).decorate  
    else
      @players = Player.where("name like '%#{params[:player_name]}%' OR full_name like '%#{params[:player_name]}%'").decorate
      render :player_results
      return
    end
    
    render :search
  end
end