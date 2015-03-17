class Expansion < ActiveRecord::Base
  has_many :plays, through: :play_expansions
  has_many :play_expansions

end
