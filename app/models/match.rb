class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  
  has_many :home_starters, -> { where side: "home", role: "starter" }, class_name: PlayerParticipation
  has_many :away_starters, -> { where side: "away", role: "starter" }, class_name: PlayerParticipation
  has_many :home_reserves, -> { where side: "home", role: "reserve" }, class_name: PlayerParticipation
  has_many :away_reserves, -> { where side: "away", role: "reserve" }, class_name: PlayerParticipation
  has_one :home_coach, -> {where side: "home", role: "coach"}, class_name: PlayerParticipation
  has_one :away_coach, -> {where side: "away", role: "coach"}, class_name: PlayerParticipation
  
  has_many :players, through: :player_participations
  
  attr_accessor :home_team_name, :away_team_name
  
  accepts_nested_attributes_for :home_starters
  accepts_nested_attributes_for :away_starters
  accepts_nested_attributes_for :home_reserves
  accepts_nested_attributes_for :away_reserves
  accepts_nested_attributes_for :home_coach
  accepts_nested_attributes_for :away_coach
    
  def result
    "#{self.home_score} : #{self.away_score}"
  end
end
