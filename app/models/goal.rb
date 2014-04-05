class Goal < ActiveRecord::Base
  belongs_to :player
  belongs_to :match

  def own_goal?
  	self.own_goal == true
  end

  def side
  	if self.match.home_players.map(&:player).include?(self.player)
  	  self.own_goal? ? "away" : "home"
  	else
  	  self.own_goal? ? "home" : "away"
  	end
  end
end
