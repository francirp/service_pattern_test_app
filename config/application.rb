require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    paths = ["#{config.root}/app/models/**/", "#{config.root}/lib/**/"]
    config.autoload_paths   += Dir[*paths]
    config.eager_load_paths += Dir[*paths]
  end
end
