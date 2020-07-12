# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

# doesn't need modifications
# job_type :command, ":task :output"

#job_type :rake,   %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bin/rake :task --silent :output }
job_type :rake, "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"
job_type :runner, %q{ cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output }
job_type :script, %q{ cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec bin/:task :output }

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

# every 1.day, at: ['10:05 am', '3:05 pm' ] do
#   rake "recover_eventos_#{ENV['CURRENT_CITY']}"
# end

# XML Sitemap updating
every 1.day, :at => '4:00 am' do
  runner "Evento.autodeletion"
end

every 1.day, :at => '4:05 am' do
  runner "Promo.autodeletion"
end

every 1.day, at: '4:10 am' do
  rake "cleanup_stale_prospects"
end

every 1.day, :at => '4:30 am' do
  rake "-s sitemap:refresh"
end

# Learn more: http://github.com/javan/whenever
