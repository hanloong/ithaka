CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               ENV['FOG_PROVIDER'],
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory  = ENV['FOG_DIRECTORY']
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
end
