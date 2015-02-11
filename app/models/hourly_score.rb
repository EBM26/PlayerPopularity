class HourlyScore < ActiveRecord::Base

  #this is here for use in hourly_score factory for testing
  belongs_to :player
  
end
