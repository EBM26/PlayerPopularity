class TotalMention < ActiveRecord::Base

  # ----------
  # If there are any missing total mention tallies from today, add them
  # ----------
  def self.create_missing_hours

    hour = Time.now.hour
    day = Time.now.yday

    i = 0

    while i <= hour
      mentions = TotalMention.find_by(hour: i)

      if mentions == nil
        TotalMention.create(hour: i, total_mentions: 1)
      end

      i += 1

    end
  end

  # ----------
  # Delete old total mention counts 
  # ----------
  def self.delete_old_hours

    hour = Time.now.hour
    day = Time.now.yday

    TotalMention.all.each do |mention| 

      if (mention.created_at.yday != day) && (mention.hour <= hour)
        mention.delete
      end

    end

  end

end
