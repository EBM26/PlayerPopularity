class Player < ActiveRecord::Base
  has_many :hourly_scores
end
