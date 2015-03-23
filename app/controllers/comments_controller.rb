class CommentsController < ApplicationController

  def create
    @play = Play.find(params[:play_id])
    @comment = @play.comments.create(comment_params)

    @comment.user_id = current_user.id

    @comment.save

    redirect_to play_path(@play)
  end


  def destroy
    @play = Play.find(params[:play_id])
    @comment = @play.comments.find(params[:id])
    @comment.destroy

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

    redirect_to play_path(@play), notice: 'Comment was successfully updated.'

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
