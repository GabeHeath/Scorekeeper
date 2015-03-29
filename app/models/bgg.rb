require 'bgg-api'
require 'open-uri'

class Bgg < ActiveRecord::Base

  # Gets the top 50 most views BGG games of the day.
  def self.cache_bgg_hotness
    bgg = BggApi.new
    content = bgg.hot({:type => "boardgame"})

    hotness_image_array = Array.new
    hotness_name_array = Array.new

    content['item'].each_with_index do |url, index|

      hotness_image_array.push("https:" + (content['item'][index]['thumbnail'][0]['value'].to_s.html_safe))
      hotness_name_array.push((content['item'][index]['name'][0]['value'].to_s.html_safe))

    end

    hotness_image_array.each_with_index do |url, index|
      open("app/assets/images/tmp/bgg_hotness/Rank_#{(index+1).to_s.rjust(2, '0')}_#{hotness_name_array[index]}.png", "wb") do |file|
        file << open(url).read
      end
    end

  end

  # Jquery-ui autocomplete calls this to get source game names
  def self.bgg_autofill_search(search_term)
    bgg = BggApi.new
    games = bgg.search( {:query => "#{search_term}", :type => 'boardgame'} )

    game_names_array = Array.new

    games['item'].each_with_index do |game, index|
        game_names_array.push((games['item'][index]['name'][0]['value']) + " (#{games['item'][index]['yearpublished'][0]['value']})") rescue nil
    end

    return game_names_array
  end


 # When play is recorded associates, this parses the game name into more info that
 # goes to the Play table and the Game table
  def self.bgg_get_name_and_id(game_name)
    name = game_name.slice(0..(game_name.length-8))
    year = game_name.slice((game_name.length-5)..(game_name.length-2))
    bgg_id = nil

    bgg = BggApi.new
    info = bgg.search( {:query => "#{name}", :type => 'boardgame', :exact => 1})

    unless info['item'].nil?
      info['item'].each_with_index do |item, index|
        if info['item'][index]['yearpublished'][0]['value'] == year
          bgg_id = (info['item'][index]['id']).to_i
          break
        end
      end
    end

    if bgg_id.nil? # Either game title that user typed doesn't exist or api failed
      return [game_name]
    else # Found match in bgg database
      return [name, year, bgg_id]
    end



  end




  # Jquery-ui autocomplete calls this to get past locations. Sorts by most frequent and limited to query.

  def self.autofill_locations_and_players(query, user, association)

    association_array = Array.new

    user_query = user.where("#{association} LIKE ?", "%#{query}%")

    saved_associations = user_query.group("#{association}").order("count_#{association} desc").count("#{association}")

    saved_associations.each do |loc|
      association_array.push(loc.first)
    end

    return association_array
  end


  def self.autofill_play_games_name(user, search_term)
    game_names = Array.new

    game_ids = user.plays.pluck(:game_id).uniq
    games = Game.where("id IN(?) AND name LIKE ?", game_ids, "%#{search_term}%")

    games.each do |game|
      game_names.push(game.name)
    end

    return game_names

  end






  end