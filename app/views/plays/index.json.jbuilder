json.array!(@plays) do |play|
  json.extract! play, :id, :game_id, :date, :notes, :created_at
  json.url play_url(play, format: :json)
end
