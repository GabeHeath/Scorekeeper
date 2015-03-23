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

  def self.search(search, page)
    games = Game.where('name LIKE ?', "%#{search}%").pluck(:id)
    paginate(:page => page, :per_page => 10).where(:game_id => games).order('date DESC')

  end
end