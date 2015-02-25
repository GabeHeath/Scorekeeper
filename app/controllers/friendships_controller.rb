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
    @friendship_created = current_user.invite(@friend)
    if @friendship_created
      redirect_to friends_path, :notice => "Your friend request is pending"
    else
      redirect_to friends_path, :flash => { :error => "Your friend request failed" }
    end
  end

  def update
    inviter = User.find_by_id(params[:id])
    if current_user.approve inviter
      redirect_to friends_path, :notice => "Successfully confirmed friend!"
    else
      redirect_to friends_path, :notice => "Sorry! Could not confirm friend!"
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if current_user.remove_friendship user
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
