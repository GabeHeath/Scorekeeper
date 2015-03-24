class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :players, dependent: :destroy
  has_many :users, through: :players

  has_many :games, through: :players
  has_many :expansions, through: :play_expansions
  has_many :play_expansions

  has_many :comments, dependent: :destroy


  accepts_nested_attributes_for :game
  accepts_nested_attributes_for :players, :reject_if => lambda { |a| a[:name].blank? }

  def self.with_friend(user, friend)
    f = user.friends
    f = f.where(:name => friend)
    unless f.empty?
      f_id = f.first.id
      f_plays = Player.where(:user_id => f_id).pluck(:play_id)
      user.plays.where(:id => f_plays) #shared_plays
    else
      return user.plays.where(:id => -1) #if friend not found then return blank object
    end



  end

end