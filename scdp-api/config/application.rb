require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ScdpApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])

    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    
    # Job queue adapter
    config.active_job.queue_adapter = :sidekiq

    # Only loads a smaller set of middleware suitable for API only apps.
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Disable rails default minitests auto generation
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: true,
        controller_specs: false

      g.fixture_replacement :factory_bot, dir: 'spec/factories'

      g.helper false
      g.assets false
    end
  end
end