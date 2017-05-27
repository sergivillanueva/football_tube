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
  has_many :goals, dependent: :destroy

  has_many :videos

  has_one :first_leg, foreign_key: 'second_leg_id', class_name: Match
  has_one :second_leg, foreign_key: 'first_leg_id', class_name: Match
  belongs_to :replay, foreign_key: 'replay_id', class_name: Match

  after_save :set_first_leg, if: :second_leg_id_changed?
  after_save :set_second_leg, if: :first_leg_id_changed?
  after_update :update_goals_competition_id, if: :competition_id_changed?

  validates :home_score, presence: true
  validates :away_score, presence: true

  scope :with_videos, -> { joins(:videos).select('matches.id').group('matches.id').having('count(videos.id) > 0') }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :available, -> { where("playing_date < '#{30.days.ago}'").where.not(competition_id: [1, 44]) }

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
  acts_as_commentable

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

  def publish!
    self.update_column(:published, true)
  end

  def recent?
    self.playing_date >= 30.days.ago
  end

  def banned?
    false
  end

  def available?
    !self.banned? && !self.recent?
  end

  def unavailable?
    !self.available?
  end

  def self.by_head_to_head ids
    Match.where("home_team_id IN (?) AND away_team_id IN (?)", ids, ids)
  end

  def self.by_season season
    Match.where(season: season)
  end

  def possible_legs
    return [] if !self.competition.present?
    self.competition.matches.published.by_head_to_head([self.home_team_id, self.away_team_id]).where.not(id: self.id).by_season(self.season)
  end

  def set_first_leg
    Match.find(self.second_leg_id_was).update_column(:first_leg_id, nil) if self.second_leg_id_was.present?
    Match.find(self.second_leg_id).update_column(:first_leg_id, self.id) if self.second_leg_id.present?
  end

  def set_second_leg
    Match.find(self.first_leg_id_was).update_column(:second_leg_id, nil) if self.first_leg_id_was.present?
    Match.find(self.first_leg_id).update_column(:second_leg_id, self.id) if self.first_leg_id.present?
  end

  def average_rating
    rc = RatingCache.find_by(cacheable: self)
    return 0 if rc.nil?
    rc.avg
  end

  def has_seekable_goals?
    self.goals.map(&:seekable?).include? true
  end

  def has_pending_seekable_goals?
    self.total_score > 0 && !self.has_seekable_goals?
  end

  def update_goals_competition_id
    # TODO There must be a better way to do this
    self.goals.each(&:save)
  end

end
