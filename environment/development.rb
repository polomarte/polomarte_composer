Rails.application.configure do
  if ENV['LIVE_RELOAD']
    config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)
  end

  config.action_controller.perform_caching   = false
  config.active_record.migration_error       = :page_load
  config.active_support.deprecation          = :log
  config.assets.debug                        = true
  config.assets.raise_runtime_errors         = true
  config.cache_classes                       = false
  config.consider_all_requests_local         = true
  config.eager_load                          = false
  config.action_mailer.preview_path          = "#{Rails.root}/lib/mailer_previews"
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings         = {
    user_name:            ENV['MAILTRAP_USER'],
    password:             ENV['MAILTRAP_PASSWORD'],
    address:              'mailtrap.io',
    domain:               'mailtrap.io',
    port:                 '2525',
    authentication:       :cram_md5,
    enable_starttls_auto: true}
end
