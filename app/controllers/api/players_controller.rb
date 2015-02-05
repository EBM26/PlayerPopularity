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

  def current_scores
    players = Player.all.order(:id)

    response_json = []

    players.each do |p|
      response_json.push(p.get_last_score)
    end

    render json: response_json
  end

end