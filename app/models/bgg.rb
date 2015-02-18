require 'bgg-api'
require 'open-uri'

class Bgg < ActiveRecord::Base

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


  def self.bgg_autofill_search(search_term)
    bgg = BggApi.new
    games = bgg.search( {:query => "#{search_term}", :type => 'boardgame'} )

    game_names_array = Array.new

    games['item'].each_with_index do |game, index|
        game_names_array.push((games['item'][index]['name'][0]['value']) + " (#{games['item'][index]['yearpublished'][0]['value']})") rescue nil
    end

    return game_names_array
  end



  def self.bgg_get_name_and_id(game_name)
    name = game_name.slice(0..(name.length-8))
    year = game_name.slice((game_name.length-5)..(game_name.length-2))
    bgg_id = nil

    bgg = BggApi.new
    info = bgg.search( {:query => "#{name}", :type => 'boardgame'}, :exact => 1)

    info['item'].each_with_index do |item, index|
      if info['item'][index]['yearpublished'][0]['value'] == year
        (info['item'][0]['id']).to_i = bgg_id
      end
    end

    if bgg.nil?
      return [name, year, bgg_id]
    else
      return [name, year]
    end



  end






end