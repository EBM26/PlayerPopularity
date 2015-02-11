  # t.string   "name"
  # t.string   "twitter_handle"
  # t.integer  "current_mentions"
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false
  # t.boolean  "switch"

class Player < ActiveRecord::Base

  validates :name, presence: true
  validates :twitter_handle, presence: true

  has_many :hourly_scores
    

  def under24?
    self.hourly_scores.count < 24
  end
  
  #return an array of all players' twitter handles
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
      scores_array.push({hour: s.hour, score: s.score})
    end

    scores_array
    
  end

  # return only most recent hourly score
  def get_last_score
    s = self.hourly_scores.last

    {name: self.name, score: s.score, hour: s.hour}
  end

  # Delete any scores older than 24 hours
  def delete_old_hourly_scores
    hour = Time.now.hour
    day = Time.now.yday

    self.hourly_scores.all.each do |score| 
      if  ((score.created_at.yday < day) && (score.hour <= hour)) || 
          (score.created_at.yday > day) || 
          ((score.created_at.yday == day) && (score.hour > hour))
        score.delete
      end
    end

  end

end
