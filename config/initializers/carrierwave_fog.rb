CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIGRY56WOCGZAR4XQ',                        # required
    :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = 'footballia'                     # required
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end