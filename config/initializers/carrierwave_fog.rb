CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => '',                        # required
    :aws_secret_access_key  => '',                        # required
  }
  config.fog_directory  = 'footballia'                     # required
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end