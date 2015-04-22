class Friendship < ActiveRecord::Base
  include Amistad::FriendModel
  include PublicActivity::Common
end