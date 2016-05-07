class Video < ActiveRecord::Base
  belongs_to :match
  mount_uploader :source_file, VideoUploader

  scope :available, -> { joins(:match).where("matches.playing_date < '#{30.days.ago}'") }
end
