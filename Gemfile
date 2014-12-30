source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails'
gem 'sass-rails'
gem 'uglifier'                                                                            # Javascript Parser
gem 'coffee-rails'                                                                        # Coffescript compilation
gem 'jquery-rails'                                                                        # jQuery wrapper with ujs rails functions
gem 'jbuilder'                                                                            # JSON Parsing
gem 'pg'                                                                                  # PostgreSQL db adapter
gem 'puma'                                                                                # Multithreaded web server
gem 'delayed_job_active_record'                                                           # ActiveRecord backed Queue
gem 'rack-cors', require: 'rack/cors'

gem 'active_model_serializers', '~> 0.8.0'

gem 'slim-rails'                                                                          # Templating language
gem 'bootstrap-sass'                                                                      # Bootstrap Wrapper
gem 'font-awesome-rails'                                                                  # Font Awersome Wrapper
gem 'autoprefixer-rails'                                                                  # Auto adds broswer prefixes to CSS
gem 'react-rails', git: 'https://github.com/reactjs/react-rails.git', ref: 'master'       # ReactJs - Facebook JS view framework
gem 'high_voltage', '~> 2.2.1'                                                            # High speed static pages

gem 'pundit'                                                                              # User Role management
gem 'devise'                                                                              # User Management
gem 'devise_invitable'                                                                    # Invitation module for devise

gem 'rubocop', require: false
gem 'english', require: false

gem 'chartkick'
gem 'groupdate'
gem 'redactor-rails'
gem 'bootstrap-switch-rails'
gem 'acts-as-taggable-on'
gem 'bootstrap_tokenfield_rails'

gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'

gem 'dynamic_sitemaps'
gem 'skylight'

gem 'google-api-client', require: 'google/api_client'
gem 'omniauth-google-oauth2'
gem 'asset_sync'
gem 'fast_blank'

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'letter_opener'
  gem 'ninefold'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'dotenv-rails'
  gem 'rspec_junit_formatter'
  gem 'jasmine-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'shoulda-matchers'
end
