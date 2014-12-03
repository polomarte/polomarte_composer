require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
        fixtures:         true,
        view_specs:       false,
        helper_specs:     false,
        routing_specs:    false,
        controller_specs: false,
        request_specs:    false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Dalli settings
    config.cache_store = :dalli_store, ENV['MEMCACHIER_SERVERS'], {
      username:             ENV['MEMCACHIER_USERNAME'],
      password:             ENV['MEMCACHIER_PASSWORD'],
      failover:             true,
      socket_timeout:       1.5,
      socket_failure_delay: 0.2,
      namespace:            -> {I18n.locale}}

    # ActionMailer Config
    config.action_mailer.default_url_options = {host: ENV['HOST']}
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false

    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'Brasilia'
  end
end
