source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.0'
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'bootstrap-slider-rails'
gem 'devise'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'slim-rails'
gem 'redcarpet', '1.17.2'
gem 'rubocop', require: false
gem 'english', require: false

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'debugger'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'minitest'                  # temp fix for rails 4.1 to stup shoulda warnings
  gem 'shoulda-matchers'
end
