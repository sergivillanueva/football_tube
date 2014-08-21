# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::Video

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  process encode_video: [:mp4, resolution: :same,  custom: '-qscale 128' ]
end
