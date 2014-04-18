class Video < ActiveRecord::Base
  belongs_to :match
  mount_uploader :file, VideoUploader
end
