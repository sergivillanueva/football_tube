# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::Video

  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  #process encode_video: [:mp4, resolution: :same,  custom: '-vcodec libx264 -acodec libfdk_aac -preset ultrafast' ]
  #process encode_video: [:mp4, resolution: :same,  custom: '-vcodec libx264 -acodec aac -crf 20 -ss 5 -to 10 -strict experimental' ]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(mp4)
  end

end
