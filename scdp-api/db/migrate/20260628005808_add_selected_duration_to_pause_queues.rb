class AddSelectedDurationToPauseQueues < ActiveRecord::Migration[7.2]
  def change
    add_column :pause_queues, :selected_duration_minutes, :integer
  end
end
