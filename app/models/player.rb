class Player < ActiveRecord::Base
  belongs_to :play, :counter_cache => true
  belongs_to :user
  belongs_to :game
end
