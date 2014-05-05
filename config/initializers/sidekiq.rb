Sidekiq.configure_server do |config|
  pool_size = Sidekiq.options[:concurrency] + 2

  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'btsidekiq', :size => pool_size }

  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    config['adapter'] = 'postgis'
    config['pool']              = pool_size
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    ActiveRecord::Base.establish_connection(config)
  end
end