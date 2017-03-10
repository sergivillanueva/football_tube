class Goal < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  belongs_to :video

  def side
  	if self.match.home_players.map(&:player).include?(self.player)
  	  self.own_goal? ? "away" : "home"
  	else
  	  self.own_goal? ? "home" : "away"
  	end
  end

  def seekable?
    self.video.present? && self.video_start_position.present?
  end
end
