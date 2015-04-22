class CommentsController < ApplicationController

  def create
    @play = Play.find(params[:play_id])
    @comment = @play.comments.create(comment_params)

    @comment.user_id = current_user.id

    @comment.save

    if @comment.save
      @comment.create_activity :create, owner: current_user

      @play.players.each do |player|
        unless player.user_id.blank? || player.user_id == current_user.id
          @notification = Notification.new
          @notification.user_id = player.user_id
          @notification.notifier_id = current_user.id
          @notification.key = "comment.included"
          @notification.trackable_id = @play.id
          @notification.save
        end
      end

      redirect_to play_path(@play)
    else
      format.html { render :new }
    end
  end


  def destroy
    @play = Play.find(params[:play_id])
    @comment = @play.comments.find(params[:id])
    @comment.destroy

    @activity = PublicActivity::Activity.where(trackable_id: (params[:id]), trackable_type: controller_path.classify)
    @activity.each do |activity|
      activity.destroy
    end

    redirect_to play_path(@play)
  end


  def edit
    @play = Play.find(params[:play_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @play = Play.find(params[:play_id])
    @comment = Comment.find(params[:id])

    @comment.update!(comment_params)
    @comment.edited = 1
    @comment.save

    if @comment.save
      @comment.create_activity :update, owner: current_user
      redirect_to play_path(@play), notice: 'Comment was successfully updated.'
    else
      format.html { render :edit }
    end
  end


  def report
    @play = Play.find(params[:play_id])
    @comment = Comment.find(params[:id])
    @comment.reported = @comment.reported + 1
    @comment.save

    redirect_to play_path(@play), notice: 'Comment was successfully reported.'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
