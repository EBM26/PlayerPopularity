class AddingBioToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :bio, :string
  end
end
