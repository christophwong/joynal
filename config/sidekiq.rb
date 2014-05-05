# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    config['adapter'] = 'postgis'
    ActiveRecord::Base.establish_connection(config)
  end
end