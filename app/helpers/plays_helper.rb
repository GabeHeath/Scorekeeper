module PlaysHelper

  def find_who_created_play(user_id)
    user = User.find(user_id)
    return user.name
  end

  def show_player_name(non_friend_name, friend_name)
    if non_friend_name != nil
      return non_friend_name
    else
      return friend_name
    end
  end

  def player_win(win)
    if win
        return "glyphicon glyphicon-ok".html_safe
    else
      return "glyphicon glyphicon-minus".html_safe
    end
  end

  def player_best_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where(:game_id => game_id).ids
    max_score =  user.players.where(:play_id => plays).pluck(:score).compact.max rescue nil

    max_score ? max_score : "N/A"
  end

  def player_average_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where(:game_id => game_id).ids
    scores = user.players.where(:play_id => plays).pluck(:score) rescue nil

    scores = scores.compact

    if scores.nil? || scores.empty?
      return "N/A"
    else
      scores.sum / scores.size.to_f
    end
  end

  def player_worst_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where(:game_id => game_id).ids
    min_score = user.players.where(:play_id => plays).pluck(:score).compact.min rescue nil

    min_score ? min_score : "N/A"
  end

  def initialize_bgg_api
    bgg = BggApi.new
  end

  def edit_play_name(play)
    name = play.game.name
    year = play.game.year

    if year.nil?
      return "#{name}"
    else
      return "#{name} (#{year})"
    end
  end

  def edit_get_player_name(player)
    if player.user
      return player.user.name
    else
      return player.non_friend_name
    end
  end

  def edit_get_player_win(player)
    return player.win #bool - T=check box F=don't check
  end

  def edit_play_colorpicker(player, color)
    if player == color
      return 'selected'
    end
  end

  def is_play_field_editable(user_id, play, pid = nil, field_type = nil)
    case field_type
      when 'select-css'
        if (user_id == play.created_by) || (user_id == pid)
          return
        else
          return "display:none;"
        end
      when 't-f'
        if (user_id == play.created_by) || (user_id == pid)
          return true
        else
          return false
        end
      when 'date'
        if (user_id == play.created_by)
          return 'datepicker'
        else
          return
        end
      else
        if (user_id == play.created_by) || (user_id == pid)
          return false
        else
          return true
        end
    end




    if user_id == play.created_by
      return false
    else
      return true
    end
  end

end
