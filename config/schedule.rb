# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# every :wednesday, at: '12pm' do # Use any day of the week or :weekend, :weekday
#   runner "Task.do_something_great"
# end
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every :thursday, at: '9:00 am' do # Use any day of the week or :weekend, :weekday
  rake "send_weekly_email"
end

every 1.day, at: ['10:05 am', '3:05 pm', '8:05 pm' ] do
  rake "recover_eventos_#{ENV['CURRENT_CITY']}"
end

# XML Sitemap updating
every 1.day, :at => '5:00 am' do
  rake "-s sitemap:refresh"
end
# Learn more: http://github.com/javan/whenever
