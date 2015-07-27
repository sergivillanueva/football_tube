class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: Team
  belongs_to :away_team, class_name: Team
  belongs_to :competition
  belongs_to :user
  
  has_many :home_players, -> { where side: "home" }, class_name: PlayerParticipation
  has_many :away_players, -> { where side: "away" }, class_name: PlayerParticipation  
  has_many :home_starters, -> { where side: "home", role: "starter" }, class_name: PlayerParticipation
  has_many :away_starters, -> { where side: "away", role: "starter" }, class_name: PlayerParticipation
  has_many :home_reserves, -> { where side: "home", role: "reserve" }, class_name: PlayerParticipation
  has_many :away_reserves, -> { where side: "away", role: "reserve" }, class_name: PlayerParticipation

  has_one :home_coach, -> {where side: "home", role: "coach"}, class_name: PlayerParticipation
  has_one :away_coach, -> {where side: "away", role: "coach"}, class_name: PlayerParticipation
  
  has_many :player_participations, dependent: :destroy
  has_many :players, through: :player_participations
  has_many :goals

  has_many :videos

  scope :with_videos, -> { joins(:videos).select('matches.id').group('matches.id').having('count(videos.id) > 0') }
  
  attr_accessor :home_team_name, :away_team_name, :competition_name

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  accepts_nested_attributes_for :home_starters, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :away_starters, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :home_reserves, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :away_reserves, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :home_coach, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :away_coach, :reject_if => proc { |p| p['player_name'].blank? }
  accepts_nested_attributes_for :goals, :reject_if => proc { |p| p['player_id'].blank? }
  accepts_nested_attributes_for :videos, :reject_if => proc { |p| p['source_file'].blank? }

  ratyrate_rateable
  
  def related_matches
    Match.where(competition: self.competition).limit(5).reject{|m| m == self} if self.competition.present? 
  end

  def total_score
    self.home_score + self.away_score
  end

  def possible_scorers
    self.players.where(:"player_participations.role" => %w(starter reserve)).order("side DESC, role DESC")
  end

  def can_have_players_set?
    return false if self.new_record?
    return self.home_team.present? && self.away_team.present?
  end

  def can_have_goals_set?
    return can_have_players_set? && self.home_score.present? && self.away_score.present?
  end

  def name
    "#{self.home_team.name} #{self.away_team.name}"
  end

  def slug_candidates
    [
      :name,
      [:name, self.competition.try(:name)],
      [:name, self.competition.try(:name), :season]
    ]
  end

  def preview_image
    PreviewImageGenerator.new(self).generate_preview_image
  end

  def mini_preview_image
    PreviewImageGenerator.new(self).generate_mini_preview_image
  end
end
