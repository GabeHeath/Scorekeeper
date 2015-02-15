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






end