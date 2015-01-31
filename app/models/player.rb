class Player < ActiveRecord::Base
  has_many :hourly_scores

  def self.twitter_handles
    player_array = []
    Player.all.each do |player|
      player_array << player.twitter_handle
    end
    return player_array
  end
end
