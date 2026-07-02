class AddExpiresAtToPauses < ActiveRecord::Migration[7.2]
  def change
    add_column :pauses, :expires_at, :datetime
  end
end
