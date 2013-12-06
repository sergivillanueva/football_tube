class PlayersController < ApplicationController
  
  def search
    players = Player.where("name like '%#{params[:name]}%'")
    render json: players.to_json
  end
    
end