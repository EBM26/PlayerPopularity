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

  #return array of hourly scores for this player from today
  def today
  end

  #return array of hourly scores for this player from this week, one per day
  def this_week
  end

  #return array of hourly scores for this player from this month, one per day
  def this_month
  end

end
