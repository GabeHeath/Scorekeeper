namespace :fix_counters do

  task :players => :environment do
    Play.find_each { |play| Play.reset_counters(play.id, :players) }
    puts "Fixed players counter cache in Play."
  end

  task :comments => :environment do
    Play.find_each { |play| Play.reset_counters(play.id, :comments) }
    puts "Fixed comments counter cache in Play."
  end

  task :all => [:players, :comments]

end

