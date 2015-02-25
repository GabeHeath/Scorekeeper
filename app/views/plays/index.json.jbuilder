@plays.each do |play|
  # json.extract! play, :id, :game_id, :date, :notes, :created_at
  # json.url play_url(play, format: :json)
  json.set! play.date.to_time.to_i, calculate_plays(play.date)
end
