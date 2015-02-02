class AddSwitchToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :switch, :boolean
  end
end
