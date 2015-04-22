class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @friends = current_user.friends
    @pending_invited_by = current_user.pending_invited_by
    @pending_invited = current_user.pending_invited
    @blocked = current_user.blocked

  end

  def create
    @friend = User.find_by_email(params[:email])

    if @friend.nil?
      redirect_to friends_path, :flash => { :error => "No users match that email address." }
    else
      @friendship_created = current_user.invite(@friend)
      if @friendship_created
        @notification = Notification.new
        @notification.user_id = @friend.id
        @notification.notifier_id = current_user.id
        @notification.key = "friend.request"
        @notification.save

        redirect_to friends_path, :notice => "Your friend request is pending"
      else
        redirect_to friends_path, :flash => { :error => "Your friend request failed" }
      end
    end
  end

  def update
    @friendship = Friendship.where(:friendable_id => params[:id], :friend_id => current_user.id).first
    inviter = User.find_by_id(params[:id])
    if current_user.approve inviter
      @friendship.create_activity :befriender, owner: current_user
      @friendship.create_activity :befriended, owner: inviter

      @notification = Notification.new
      @notification.user_id = inviter.id
      @notification.notifier_id = current_user.id
      @notification.key = "friend.accepted"
      @notification.save

      redirect_to friends_path, :notice => "Successfully confirmed friend!"
    else
      redirect_to friends_path, :notice => "Sorry! Could not confirm friend!"
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    trackable_id = Friendship.where(' (friendable_id = ? OR friendable_id = ?) AND (friend_id = ? OR friend_id = ?) ', current_user.id, params[:id], current_user.id, params[:id]).first.id

    if current_user.remove_friendship user
      @activity = PublicActivity::Activity.where(trackable_id: trackable_id, trackable_type: controller_path.classify)
      @activity.each do |activity|
        activity.destroy
      end

      redirect_to friends_path, :notice => "Successfully removed friend!"
    else
      redirect_to friends_path, :notice => "Sorry, couldn't remove friend!"
    end
  end

  def block
    user = User.find_by_id(params[:id])
    if current_user.block user
      redirect_to friends_path, :notice => "Successfully blocked user!"
    else
      redirect_to friends_path, :notice => "Sorry, couldn't block user!"
    end
  end

  def unblock
    user = User.find_by_id(params[:id])
    if current_user.unblock user
      redirect_to friends_path, :notice => "Successfully unblocked user!"
    else
      redirect_to friends_path, :notice => "Sorry, couldn't unblock user!"
    end
  end

end
