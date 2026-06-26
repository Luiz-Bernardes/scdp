class AddIndexesToPauseTypes < ActiveRecord::Migration[7.2]
  def change
    add_index :pause_types, [:team_id, :name], unique: true
  end
end
