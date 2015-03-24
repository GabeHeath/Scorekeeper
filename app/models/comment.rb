class Comment < ActiveRecord::Base
  belongs_to :play, :counter_cache => true
  belongs_to :user
end
