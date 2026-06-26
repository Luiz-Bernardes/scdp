class CreatePauseQueues < ActiveRecord::Migration[7.2]
  def change
    create_table :pause_queues do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :pause_type, null: false, foreign_key: true
      t.integer :position
      t.string :status
      t.datetime :requested_at

      t.timestamps
    end
  end
end
