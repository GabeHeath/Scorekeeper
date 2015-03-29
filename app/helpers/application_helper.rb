require 'bgg-api'

module ApplicationHelper

#Dynamic titles on each page
  def title(page_title)
    content_for(:title) { page_title }
  end

  def bgg_hotness
    bgg = BggApi.new
    content = bgg.hot({:type => "boardgame"})

    hotness_image_array = Array.new
    hotness_name_array = Array.new

    content['item'].each_with_index do |url, index|

      hotness_image_array.push("https:" + (content['item'][index]['thumbnail'][0]['value'].to_s.html_safe))
      hotness_name_array.push((content['item'][index]['name'][0]['value'].to_s.html_safe))

    end

    html = ""
    html += "<div id='hotness-thumbnails'>"

    hotness_image_array.each_with_index do |url, index|
      html += "<img src='#{url}' title='#{hotness_name_array[index]}' >"
    end

    html += "</div>"

    html.html_safe
  end


  def link_to_remove_player(name, f)
    link_to(name, '#players-table', onclick: "remove_player(this)", :class=>'close')
  end

  def link_to_remove_expansion(name, f)
    link_to(name, '#expansion-table', onclick: "remove_expansion(this)", :class=>'close')
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize  + "_fields", f: builder)
    end

    case association.to_s.singularize
      when 'player'
        link_to(name, '#players-table', class: "add_player btn btn-primary btn-block", data: {id: id, fields: fields.gsub("\n","")})
      when 'game'
        link_to(name, '#expansion-table', class: "add_expansion btn btn-primary btn-block", data: {id: id, fields: fields.gsub("\n","")})
    end
  end



end