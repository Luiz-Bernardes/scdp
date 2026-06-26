class AddActivePauseConstraint < ActiveRecord::Migration[7.2]
  def change
    add_index :pauses,
      :user_id,
      unique: true,
      where: "status = 0",
      name: "index_unique_active_pause_per_user"
  end
end
