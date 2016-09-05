class LogsWorker
  include Sidekiq::Worker

  def perform
    Log.all.each do |log|
      if log.enter_time != nil and log.exit_time == nil and log.enter_time + 3.hours <= DateTime.now
        log.exit_time = log.enter_time + 3.hours
      end
    end
  end
end

Sidekiq::Cron::Job.create(name: 'Logs worker every 5min', cron: '*/5 * * * *', class: LogsWorker)