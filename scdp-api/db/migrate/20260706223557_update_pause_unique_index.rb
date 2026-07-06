class UpdatePauseUniqueIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :pauses,
      name: "index_unique_active_pause_per_user"

    add_index :pauses,
      :user_id,
      unique: true,
      where: "status IN (0,1,2)",
      name: "index_unique_running_pause_per_user"
  end
end
