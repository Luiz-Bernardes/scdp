class AddMaxDurationMinutesToPauseTypes < ActiveRecord::Migration[7.2]
  def change
    add_column :pause_types, :max_duration_minutes, :integer
  end
end
