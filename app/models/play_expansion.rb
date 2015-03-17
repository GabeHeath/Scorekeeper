class PlayExpansion < ActiveRecord::Base
  belongs_to :play
  belongs_to :expansion
end
