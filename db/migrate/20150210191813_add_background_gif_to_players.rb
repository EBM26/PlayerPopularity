class AddBackgroundGifToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :bggif, :string
  end
end
