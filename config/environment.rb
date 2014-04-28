# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address:        'smtp.sendgrid.net',
  port:           '25',
  authentication: :plain,
  user_name:      ENV['SENDGRID_USERNAME'],
  password:       ENV['SENDGRID_PASSWORD'],
  domain:         'ithaka.io',
  enable_starttls_auto: true
}
