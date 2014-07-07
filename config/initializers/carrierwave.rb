CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               ENV.fetch('FOG_PROVIDER', ''),
    aws_access_key_id:      ENV.fetch('AWS_ACCESS_KEY_ID', ''),
    aws_secret_access_key:  ENV.fetch('AWS_SECRET_ACCESS_KEY', ''),
  }
  config.fog_directory  = ENV.fetch('FOG_DIRECTORY', '')
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
end
