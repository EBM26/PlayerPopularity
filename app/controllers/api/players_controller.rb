class Api::PlayersController < ApplicationController

  def index
    players = Player.all.order(:id)
    render json: players.to_json

  end

  def show
    begin
      player = Player.find(params[:id])
      response_json = player.to_json(include: :hourly_scores)
    rescue ActiveRecord::RecordNotFound
      response_json = { status: 404,
                        message: "Player with ID #{params[:id]} could not be found"}.to_json
    end

    render json: response_json

  end

  # render JSON containing an array with each player's most recent hourly score
  # eg: {[{name: "Kobe Bryant", score: 740.0, hour: 22}, {...}, {...} ...]}
  def current_scores
    players = Player.all.order(:id)

    response_json = []

    players.each do |p|
      response_json.push(p.get_last_score)
    end

    render json: response_json
  end

  # render JSON containing an array of each player, each player containing an array
  # of each of their last 24 hourly scores
  def hourly_scores
    players = Player.all.order(:id)

    response_json = []

    players.each do |p|
      response_json.push({name: p.name, scores: p.get_hourly_scores})
    end

    render json: response_json
  end

  # render JSON containing the hourly scores of the 5 players leading in current mentions
  def top_five
    players = Player.all.order(current_mentions: :desc).limit(5)

    response_json = []

    players.each do |p|
      response_json.push({name: p.name, scores: p.get_hourly_scores, current_mentions: p.current_mentions})
    end

    render json: response_json
  end

  # render JSON containing list of players in DB and their ID
  def list_with_ids
    players = Player.all.order(:id)
    render json: players.to_json(only: [:id, :name])
  end

end