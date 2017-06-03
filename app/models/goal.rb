class Goal < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  belongs_to :video
  belongs_to :team
  belongs_to :competition

  before_save :set_team_id, if: Proc.new { |goal| goal.player_id_changed? }
  before_save :set_competition_id
  before_save :set_source_file, if: Proc.new { |goal| goal.video_start_position_changed? || goal.video_end_position_changed? || goal.video_id_changed? }

  # TODO move this to cron
  after_save :remove_tmp_file

  scope :trimmed, -> { where.not(source_file: nil) }

  mount_uploader :source_file, VideoUploader

  validate :video_position_values_order

  def video_position_values_order
    return unless self.video_start_position.present? && self.video_end_position.present?

    unless self.video_end_position > self.video_start_position
      self.errors.add :video_end_position, "Video end position value must be greater than video start value."
      self.errors.add :video_start_position, "Video end position value must be greater than video start value."
    end
  end

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

  def set_source_file
    return unless self.video.present? && self.video_start_position.present? && self.video_end_position.present?
    path = GoalTrimmer.new(self).generate_source_file
    self.source_file = File.open path
  rescue Errno::ENOENT
    self.errors.add :video_id, "Video not found."
    return false
  end

  def remove_tmp_file
    GoalTrimmer.new(self).remove_tmp_file
  end

  def set_team_id
    self.team_id = self.side == 'home' ? self.match.home_team_id : self.match.away_team_id
  end

  def set_competition_id
    self.competition_id = self.match.competition_id
  end
end
