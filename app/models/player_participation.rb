class PlayerParticipation < ActiveRecord::Base
  belongs_to :match
  belongs_to :player
  has_many :goals
  
  attr_accessor :player_name
end
