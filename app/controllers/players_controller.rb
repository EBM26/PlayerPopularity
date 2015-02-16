class PlayersController < ApplicationController
  

  def index


    @player = Player.all.order(current_mentions: :asc)
    @player1 = @player.last.name.split(" ")
    @player2 = @player[-2].name.split(" ")
    @player3 = @player[-3].name.split(" ")
    @player4 = @player[-4].name.split(" ")
    @player5 = @player[-5].name.split(" ")
    # to set up a blank search bar
    @people = 'hi'
    @totalmentions = TotalMention.all
  end


  def show
    @player = Player.find(params[:id])
  end

  def all
    @players = Player.all .order(current_mentions: :desc)
    @totalmentions =TotalMention.all
  end

  def search
    player = Player.find_by(name: params[:query])

    if player
      redirect_to player_path(player.id)
    else
      redirect_to players_path
    end

  end


end
