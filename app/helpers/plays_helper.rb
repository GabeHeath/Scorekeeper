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

  def player_highest_losing_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where('game_id = ? AND win = ?', game_id, false).ids
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

  def player_average_winning_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where('game_id = ? AND win = ?', game_id, true).ids
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

  def player_lowest_winning_score(user_id, game_id)
    user = User.find(user_id)
    plays = user.plays.where('game_id = ? AND win = ?', game_id, true).ids
    min_score = user.players.where(:play_id => plays).pluck(:score).compact.min rescue nil

    min_score ? min_score : "N/A"
  end

  def player_win_percentage(user_id, game_id)
    plays = Player.joins(:play).group("plays.game_id").where(' user_id = ? AND game_id = ?', user_id, game_id)

    total_plays = plays.count.first[1].to_f
    total_wins =  plays.where(:win => true).count
    unless total_wins.empty?
      total_wins = total_wins.first[1].to_f

    else
      total_wins = 0.0
    end

    return ((total_wins/total_plays)*100.0).round

  end

  def player_most_defeated_friend(user_id, game_id)
    loser_ids = []
    user = User.find(user_id)
    plays = user.plays.where('game_id = ? AND win = ?', game_id, true)

    plays.each do |play|
      loser_ids.push(play.players.where(:win => false).pluck(:user_id).compact)
    end

    loser = loser_ids.max_by{|x| loser_ids.count(x) }

    unless loser.blank?
      return User.find(loser.first).name
    else
      return "N/A"
    end
  end

  def player_most_defeated_by(user_id, game_id)
    winner_ids = []
    user = User.find(user_id)
    plays = user.plays.where('game_id = ? AND win = ?', game_id, false)

    plays.each do |play|
      winner_ids.push(play.players.where(:win => true).pluck(:user_id).compact)
    end

    winner = winner_ids.max_by{|x| winner_ids.count(x) }

    unless winner.blank?
      return User.find(winner.first).name
    else
      return "N/A"
    end
  end

  def player_most_played_location(user_id, game_id)
    locations = []
    user = User.find(user_id)
    plays = user.plays.where(:game_id => game_id)

    plays.each do |play|
      locations.push(play.location)
    end

    location = locations.max_by{|x| locations.count(x) }

    unless location.blank?
      return location
    else
      return "N/A"
    end
  end

  def player_average_num_players(user_id, game_id)
    players = []
    user = User.find(user_id)
    plays = user.plays.where(:game_id => game_id)

    plays.each do |play|
      players.push(play.players.count)
    end

    total = players.inject(:+)
    return ((total.to_f) / (players.length)).round
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

  def is_row_important(user_id, current_user, param_id)

    if user_id == current_user
      return 'current-user-row'
    elsif user_id == param_id
      return 'friend-row'
    else
      return
    end
  end


  def calculate_plays(user, date)
    return user.plays.where(:date => date).count
  end

  def get_heatmap_play_counts(user_id)
    @hash = {}
    @user = User.find(user_id)

    @user.plays.each do |play|
      @hash[play.date.to_time.to_i] = calculate_plays(@user, play.date)
    end

    return @hash.to_json

  end

end
