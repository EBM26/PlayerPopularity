class CreateTotalMentions < ActiveRecord::Migration
  def change
    create_table :total_mentions do |t|
      t.integer :total_mentions
      t.integer :yearday
      t.integer :hour

      t.timestamps null: false
    end
  end
end
