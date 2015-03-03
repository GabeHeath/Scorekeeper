class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]

  # GET /plays
  # GET /plays.json
  def index
    @plays = current_user.plays
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
    @plays = current_user.plays
    if user_signed_in?
      unless current_user.id == @play.user_ids[0]
        flash[:error] = "The page you requested does not exist."
        redirect_to plays_url
        return
      end
    else
      flash[:error] = "Please log in."
      redirect_to root_path
      return
    end
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1/edit
  def edit
  end

  # POST /plays
  # POST /plays.json
  def create

    @play = Play.new(play_params)
    @play.created_by = current_user.id

    @game = Game.new(game_params)
      # Parse and set game_id
      data = Bgg.bgg_get_name_and_id((@game.name).to_s) #Returns array of 2 if name user typed doesn't exist or api failed. Returns 3 if found in BGG database.
      attributes = {name: data[0], year: data[1], bgg_id: data[2], game_type: 'primary'}
      @new_game = Game.where(attributes).first_or_create

        @play.game_id = @new_game.id



    respond_to do |format|
      if @play.save
        name = params[:name].unshift(current_user.name)
        name.each_with_index do |name, index|
          @player = Player.new
          if index == 0
            @player.user_id = current_user.id
          else
            friend_user_id = get_friend_user_id(name, current_user.friends)
            logger.debug "EQUALS: #{friend_user_id}"
            if friend_user_id
              logger.debug "NOT NIL"
              @player.user_id = friend_user_id
            else
              logger.debug "NON FRIEND"
              @player.non_friend_name = name
            end
          end
          @player.play_id = @play.id
          @player.score = params[:score][index]
          @player.win = params[:win][index]
          @player.save
        end





        if @player.save
          format.html { redirect_to @play, notice: 'Play was successfully created.' }
          format.json { render :show, status: :created, location: @play }
        else
          format.html { render :new }
          format.json { render json: @play.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'Play was successfully updated.' }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:game_id, :date, :location, :notes, :created_at)
    end

  def game_params
    params.require(:game).permit(:name, :year, :bgg_id, :game_type)
  end

  def player_params
    params.require(:player).permit(:score, :win, :_destroy) #:play_id, :user_id, :score, :win,
  end

  def get_friend_user_id(player_name, users_friends)
    users_friends.each do |friend|
      if friend.name == player_name
        return friend.id
      end
    end
    return
  end

end
