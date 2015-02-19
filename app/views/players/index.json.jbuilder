json.array!(@players) do |player|
  json.extract! player, :id, :play_id, :user_id, :score, :win
  json.url player_url(player, format: :json)
end
