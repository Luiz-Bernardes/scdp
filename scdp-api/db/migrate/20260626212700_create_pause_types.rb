class CreatePauseTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :pause_types do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.boolean :has_time_limit
      t.integer :max_concurrent
      t.boolean :requires_queue
      t.boolean :active

      t.timestamps
    end
  end
end
