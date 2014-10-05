CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                        # required
    :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
    :region => 'us-west-2'
  }
  config.fog_directory  = 'footballia'                     # required
  config.fog_public     = true
  #config.fog_attributes = { :multipart_chunk_size => 104857600 }
end