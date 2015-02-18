class Play < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  accepts_nested_attributes_for :game


  before_save :get_bgg_info


  private

  def get_bgg_info
    data = Bgg.bgg_get_name_and_id(@game.name)

    logger.debug "Finally: #{data}"
    # if data.length < 2
    # #Search through table to see if it already exists
    # else
    #
    # end

  end

end