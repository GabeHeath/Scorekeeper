class UsersController < ApplicationController
  def show
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = 10
    end

    @user = User.find(params[:id])
    search = params[:search]

    games_id_array = order_array_by_occurrence(@user.plays.pluck(:game_id))
    @plays = Game.where('id IN(?) AND name LIKE ?', games_id_array, "%#{search}%").order("field(id,#{games_id_array.join(',')})").paginate(:page => params[:page], :per_page => @per_page)

    @play_dates = @user.plays
  end

  def compare
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = 10
    end

    search = params[:search]

    @game = Game.find(params[:game_id])
    player_ids = Player.joins(:play).where(:plays=>{:game_id=>params[:game_id]}).where('user_id = ? OR user_id IN(?)', current_user.id, current_user.friends.ids).pluck(:user_id).uniq

    if player_ids.include?(current_user.id)
      @friends = User.where('(id IN(?) AND name LIKE ?) OR (id = ?)', player_ids, "%#{search}%", current_user.id).paginate(:page => params[:page], :per_page => @per_page)
    else
      @friends = User.where('id IN(?) AND name LIKE ?', player_ids, "%#{search}%").paginate(:page => params[:page], :per_page => @per_page)
      @not_included = true
    end


  end


  def root
    redirect_to user_path(current_user.id)
  end


  private

  def order_array_by_occurrence(array)
    return array.group_by{|x| x}.sort_by{|k, v| -v.size}.map(&:first)
  end
end
