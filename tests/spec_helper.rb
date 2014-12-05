# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/email/rspec'
require 'rspec/autorun'
require 'simplecov'
require 'capybara/poltergeist'

if ENV['COV']
  SimpleCov.start do
    add_filter "app/admin/"
    add_filter "spec/"
  end
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true)
end

Capybara.server_port = 31000
# Capybara.javascript_driver = :poltergeist_debug
Capybara.javascript_driver = :poltergeist


RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Features::Sessions, type: :feature

  config.filter_run wip: true
  config.run_all_when_everything_filtered = true

  ActiveRecord::Migration.maintain_test_schema!

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.after :each do
    Timecop.return
  end
end
