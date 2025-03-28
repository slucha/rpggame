require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rpggame
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # Configure CORS for API access
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # Instead of '*', specify the exact origins you want to allow
        origins 'localhost:3000', 
                /\A(https?:\/\/)?(\w+\.)?gitpod\.io\z/
        
        resource '*', 
          headers: :any, 
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client']
      end
    end
    
    # Host checking is managed by initializers/direct_host_config.rb
    
    # Load Gitpod specific configuration
    require_relative "gitpod_config" if File.exist?(Rails.root.join("config/gitpod_config.rb"))
  end
end
