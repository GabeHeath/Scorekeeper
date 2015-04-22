class Comment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :play, :counter_cache => true
  belongs_to :user
end
