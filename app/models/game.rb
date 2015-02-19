class Game < ActiveRecord::Base
  has_many :plays
  has_many :users, :through => :plays

  #un tested but feel pretty good about
  has_many :collections
  has_many :players, through: :collections


end
