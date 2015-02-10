class AddFactsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :facts, :string, array: true
  end
end
