class Match < ActiveRecord::Base
  has_one :home_team, class_name: :club, foreign_key: :home_team_id
  has_one :away_team, class_name: :club, foreign_key: :away_team_id
  
  attr_accessible :home_score, :away_score, :playing_date
end
