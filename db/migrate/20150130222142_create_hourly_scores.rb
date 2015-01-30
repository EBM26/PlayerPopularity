class CreateHourlyScores < ActiveRecord::Migration
  def change
    create_table :hourly_scores do |t|
      t.float :score

      t.timestamps null: false
    end
  end
end
