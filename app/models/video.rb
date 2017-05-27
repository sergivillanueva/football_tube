class Video < ActiveRecord::Base
  has_many :goals
  belongs_to :match
  mount_uploader :source_file, VideoUploader

  scope :available, -> { joins(:match).where("matches.playing_date < '#{30.days.ago}'") }

  def destroy
    raise "Cannot delete video with goals" unless self.goals.count == 0
    super
  end
end
