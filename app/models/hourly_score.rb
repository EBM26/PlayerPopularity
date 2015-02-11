class HourlyScore < ActiveRecord::Base

  #this is here for use in hourly_score factory for testing
  belongs_to :player

  after_create :remove_old_scores


  # delete all scores older than 24 hours
  def remove_old_scores

    scores = self.player.hourly_scores.order(:hour) if self.player
    day = Time.now.yday
    hour = Time.now.hour

    if scores
      scores.each do |score| 
        if (score.created_at.yday != day) && (score.hour <= hour)
            score.delete
        end
      end
    end

    # if self.player
    #   scores = self.player.hourly_scores.order(:)
    # end

  end
  
end
