class PlayersController < ApplicationController
  

  def index
    @players = Player.all.order(current_mentions: :desc)
    # to set up a blank search bar
    @people = 'hi'
  end


  def show
    @player = Player.find(params[:id])
  end


end
