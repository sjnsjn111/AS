set :environment, "development"
set :output, {error: "log/cron_error_log.log", standard: "log/cron_log.log"}

every 1.day, at: "8:30 am" do
  rake "redmire:notes"
end
