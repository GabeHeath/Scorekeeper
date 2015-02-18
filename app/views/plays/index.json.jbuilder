json.array!(@plays) do |play|
  json.extract! play, :id, :play_id, :game_id, :user_id, :score, :win, :date, :notes, :created_at
  json.url play_url(play, format: :json)
end
