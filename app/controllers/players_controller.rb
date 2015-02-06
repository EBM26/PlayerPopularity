class PlayersController < ApplicationController
  

  def index
    @player = Player.all.order(current_mentions: :asc)
    # to set up a blank search bar
    @people = 'hi'
  end


  def show
    @player = Player.find(params[:id])
  end


end
