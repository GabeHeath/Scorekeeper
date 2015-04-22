module UsersHelper
  def did_user_win(bool)
    if bool
      return " and won!".html_safe
    else
      return ".".html_safe
    end
  end

  def activity_play_icon(bool)
    if bool
      return "fa fa-trophy win".html_safe
    else
      return "glyphicon glyphicon-knight".html_safe
    end
  end

  def list_players_names(player_id, win)
   player = Player.find(player_id)

    if player.user_id
      return link_to player.user.name, user_path(player.user.id), class: list_player_name_class(win)
    else
      return content_tag(:span, player.non_friend_name, class: list_player_name_class(win))
    end
  end

  def list_player_name_class(win)
    return "winner".html_safe if win
  end
end
