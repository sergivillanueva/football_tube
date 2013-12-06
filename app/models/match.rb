class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  has_many :home_player_participations, -> { where side: "home" }, 
                                        class_name: PlayerParticipation
  has_many :away_player_participations, -> { where side: "away" },
                                        class_name: PlayerParticipation
  has_many :players, through: :player_participations
  
  attr_accessor :home_team_name, :away_team_name
  
  accepts_nested_attributes_for :home_player_participations
  accepts_nested_attributes_for :away_player_participations
end
