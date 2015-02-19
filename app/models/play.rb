class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :players
  has_many :users, through: :players

  accepts_nested_attributes_for :game
  # accepts_nested_attributes_for :player


  # after_save :add_players
  #
  #
  # private
  #
  # def add_players()
  #   @player = Player.new(player_params)
  #   @player.user_id = current_user.id
  #   @player.game_id =
  # end

end