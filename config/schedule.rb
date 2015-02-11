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

# Learn more: http://github.com/javan/whenever

set :environment, 'development'

set :output, {:error => "#{path}/log/cron_error_log.log", :standard => "#{path}/log/cron_log.log"}
#set :output, "#{path}/log/cron_log.log"



# every 5.minutes do #:reboot do # 1.day, :at => "1am"
#   runner "Bgg.cache_bgg_hotness"
#   command "mv #{path}/tmp/bgg_hotness #{path}/tmp/bgg_hotness_#{Date.today.to_s}"
#   command "mkdir #{path}/tmp/bgg_hotness"
#
# end




# every :tuesday, :at => "7:10pm" do
#   runner "Bgg.cache_bgg_hotness"
# end
#
# every :tuesday, :at => "7:20pm" do
#   command "mv #{path}/tmp/bgg_hotness #{path}/tmp/bgg_hotness_#{Date.today.to_s}"
#   command "mkdir #{path}/tmp/bgg_hotness"
# end





# To stop cron
# whenever -c scorekeeper

# To update
#whenever --update-crontab scorekeeper




every 1.day, :at => "10:00am" do
  runner "Bgg.cache_bgg_hotness"
end

every 1.day, :at => "10:30am" do
  command "cp -r #{path}/app/assets/images/tmp/bgg_hotness #{path}/app/assets/images/tmp/bgg_hotness_#{Date.today.to_s}"
end