set :environment, "development"
set :output, {error: "log/cron_error_log.log", standard: "log/cron_log.log"}

# every 1.day, at: "10:35 pm" do
every 12.hours do
  rake "redmire:notes"
end
