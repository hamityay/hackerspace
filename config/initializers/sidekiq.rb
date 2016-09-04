Sidekiq.configure_server do |config|
  config.periodic do |mrg|
    mrg.register('*/5 * * * *', LogsWorker, retry: 2, queue: 'default')
  end
  config.redis = {url: ENV['REDISTOGO_URL'] }
end unless ENV['REDISTOGO_URL'].blank?

Sidekiq.configure_client do |config|
  config.periodic do |mrg|
    mrg.register('*/5 * * * *', LogsWorker, retry: 2, queue: 'default')
  end
  config.redis = { url: ENV['REDISTOGO_URL']}
end unless ENV['REDISTOGO_URL'].blank?

schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) and Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
# Open this if you have scheduled jobs
# schedule_file = 'config/schedule.yml'
# if File.exists?(schedule_file) && Sidekiq.server?
#   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
# end