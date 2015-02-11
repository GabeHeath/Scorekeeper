require 'bgg-api'
require 'open-uri'

module ApplicationHelper

#Dynamic titles on each page
  def title(page_title)
    content_for(:title) { page_title }
  end

  def bgg_hotness
    # bgg = BggApi.new
    # content = bgg.hot({:type => "boardgame"})
    #
    # hotness_image_array = Array.new
    # hotness_name_array = Array.new
    #
    # content['item'].each_with_index do |url, index|
    #
    #   hotness_image_array.push("https:" + (content['item'][index]['thumbnail'][0]['value'].to_s.html_safe))
    #   hotness_name_array.push((content['item'][index]['name'][0]['value'].to_s.html_safe))
    #
    # end
    #
    # html = ""
    # html += "<div id='hotness-thumbnails'>"
    #
    # hotness_image_array.each_with_index do |url, index|
    #   html += "<img src='#{url}' title='#{hotness_name_array[index]}' >"
    # end
    #
    # html += "</div>"
    #
    # html.html_safe

    html = ""
    html += "<div id='hotness-thumbnails'>"
      Dir.foreach('app/assets/images/tmp/bgg_hotness/') do |image|
        unless image == "." || image == ".."
          html += image_tag("tmp/bgg_hotness/#{image}", :title => "#{image[0..-5]}" )
          #html += "<img src='#{image-url(image)}' title='#{image[0..-5]}' >"
        end
      end
    html += "</div>"

    html.html_safe
  end

end
