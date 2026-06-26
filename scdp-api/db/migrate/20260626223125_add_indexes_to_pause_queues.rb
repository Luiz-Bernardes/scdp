class AddIndexesToPauseQueues < ActiveRecord::Migration[7.2]
  def change
    add_index :pause_queues,
      [:user_id, :pause_type_id],
      unique: true,
      name: "index_unique_queue_per_user_pause_type"
  end
end
