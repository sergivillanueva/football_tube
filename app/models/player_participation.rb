class PlayerParticipation < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  
  attr_accessor :player_name
end
