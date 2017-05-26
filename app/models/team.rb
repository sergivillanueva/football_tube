class Team < ActiveRecord::Base
  has_many :home_matches, foreign_key: :home_team_id, class_name: Match
  has_many :away_matches, foreign_key: :away_team_id, class_name: Match
  has_many :goals

  belongs_to :country

  mount_uploader :logo, LogoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def as_json(options={})
    { 
      id: self.id,
      value: self.name,
      name: self.name,
      logo_mini: self.logo.mini.url,
      logo_thumb: self.logo.thumb.url,
      slug: self.slug,
      logo_medium: self.logo.medium.url
    }
  end

  def matches
    self.home_matches + self.away_matches
  end

  def destroy
    raise "Cannot delete team with matches" unless self.matches.count == 0
    super
  end

end
