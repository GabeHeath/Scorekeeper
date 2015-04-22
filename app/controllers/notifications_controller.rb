class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 25).order('created_at DESC')
  end

  def clear_new
    @notifications = Notification.where(:user_id => current_user.id, :new => true).limit(10).order('created_at DESC')

    unless @notifications.nil?
      @notifications.each do |notification|
        notification.new = false
        notification.save
      end

     redirect_to notifications_path
    end

    return
  end

  def mark_read
    @notification = Notification.find(params[:notification])

    @notification.read = true
    @notification.save

    redirect_to notifications_path
  end
end
