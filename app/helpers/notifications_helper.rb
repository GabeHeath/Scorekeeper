module NotificationsHelper
  def get_notifier_name(id)
    return User.find(id).name
  end

  def get_notification_play(id)
    return Play.find(id).game.name
  end

  def is_notification_new(id)
    if Notification.find(id).new
      return "new".html_safe
    else
      return "old".html_safe
    end
  end
end
