require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Votation
  class Application < Rails::Application
    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false
    end

    config.serve_static_assets = true
    config.assets.precompile += ['home.js', 'home.css']
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_paths += %W(
    #{config.root}/app/presenters
    )

    ## React Server Side rendering
    config.react.max_renderers = 10
    config.react.timeout = 20 #seconds
    config.react.addons = true
  end
end
