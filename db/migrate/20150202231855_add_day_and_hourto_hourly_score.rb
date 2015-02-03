class AddDayAndHourtoHourlyScore < ActiveRecord::Migration
  def change
  	add_column :hourly_scores, :yearday, :integer
  	add_column :hourly_scores, :hour, :integer
  end
end
