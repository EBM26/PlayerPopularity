class Api::MentionsController < ApplicationController

  def index
    mentions = TotalMention.all.order(:id)
    render json: mentions.to_json
  end

  def today
    render json: "today"
  end

  def hour
    hour = params[:hour]
    render json: {hour: hour}.to_json
  end

end