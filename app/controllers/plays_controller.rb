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
    @play = Play.find params[:id]
    if user_signed_in?
      unless current_user.id == @play.user_id
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
    @play.play_id = Play.maximum(:play_id).to_i.next
    @play.user_id = current_user.id

    #@game = Game.new(params[:game])
    @game = Game.new(game_params)
    @game.game_type = "primary"


    respond_to do |format|
      if @play.save && @game.save
        format.html { redirect_to @play, notice: 'Play was successfully created.' }
        format.json { render :show, status: :created, location: @play }
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
      params.require(:play).permit(:play_id, :game_id, :user_id, :score, :win, :date, :notes, :created_at)
    end

  def game_params
    params.require(:game).permit(:name, :year, :bgg_id, :game_type)
  end

end
