class Video < ActiveRecord::Base
  belongs_to :match
  mount_uploader :source_file, VideoUploader
end
