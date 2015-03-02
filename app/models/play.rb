class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :players
  has_many :users, through: :players


  accepts_nested_attributes_for :game
  accepts_nested_attributes_for :players, :reject_if => lambda { |a| a[:name].blank? }



end