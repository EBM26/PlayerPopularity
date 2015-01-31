class AddPlayerToHourlyScore < ActiveRecord::Migration
  def change
    add_reference :hourly_scores, :player,  index: true
    add_foreign_key :hourly_scores, :players
  end
end
