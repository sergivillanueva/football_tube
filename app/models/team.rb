class Team < ActiveRecord::Base
  has_many :home_matches, foreign_key: :home_team_id, class_name: Match
  has_many :away_matches, foreign_key: :away_team_id, class_name: Match

  belongs_to :country
  
  mount_uploader :logo, LogoUploader
  
  def as_json(options={})
    { 
      id: self.id,
      value: self.name,
      name: self.name,
      logo: self.logo.url,
      logo_mini: self.logo.mini.url,
      logo_thumb: self.logo.thumb.url
    }
  end

  def matches
    self.home_matches + self.away_matches
  end

end
