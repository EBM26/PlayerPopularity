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
  def get_scores

    scores_objects = self.hourly_scores.order(:hour)

    scores_array = []

    scores_objects.each do |s|
      scores_array.push({hour: s.hour, score: s.score})
    end

    scores_array
    
  end

end
