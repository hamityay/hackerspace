class LogsWorker
  include Sidekiq::Worker
  include ActiveRecord::Base

  def perform
    Log.all.each do |log|
      if log.enter_time != nil and log.exit_time == nil
        log.exit_time = DateTime.now if log.enter_time + 3.hours <= DateTime.now
      end
    end
  end
end

Sidekiq::Cron::Job.create(name: 'Logs worker every 5min', cron: '*/5 * * * *', class: LogsWorker)