class CreatePauses < ActiveRecord::Migration[7.2]
  def change
    create_table :pauses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :pause_type, null: false, foreign_key: true
      t.integer :selected_duration_minutes
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :status

      t.timestamps
    end
  end
end
