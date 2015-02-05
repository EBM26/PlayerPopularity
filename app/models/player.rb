class Player < ActiveRecord::Base
  has_many :hourly_scores

  #return an array of all player's twitter handles
  def self.twitter_handles
    player_array = []

    Player.all.each do |player|
      player_array << player.twitter_handle
    end

    return player_array
  end

  #return array of all hourly scores for this player
  def get_hourly_scores

    hourly_scores = self.hourly_scores.order(:hour)

    scores_array = []

    hourly_scores.each do |s|
      scores_array.push(s.score)
    end

    scores_array
    
  end

  #return only most recent hourly score
  def get_last_score
    s = self.hourly_scores.last

    {name: self.name, score: s.score, hour: s.hour}
  end

end
