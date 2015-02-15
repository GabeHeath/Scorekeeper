class BggSearchSuggestionsController < ApplicationController
  def index
    render json: Bgg.bgg_autofill_search(params[:term])
  end
end