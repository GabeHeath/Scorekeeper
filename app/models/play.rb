class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :players, dependent: :destroy
  has_many :users, through: :players

  has_many :games
  has_many :expansions, through: :play_expansions
  has_many :play_expansions

  has_many :comments, dependent: :destroy


  accepts_nested_attributes_for :game
  accepts_nested_attributes_for :players, :reject_if => lambda { |a| a[:name].blank? }



end