class SearchController < ApplicationController
  def search_by_player
    @player_participations = PlayerParticipation.where(player_id: params[:player_id]).decorate
    render :search
  end
end