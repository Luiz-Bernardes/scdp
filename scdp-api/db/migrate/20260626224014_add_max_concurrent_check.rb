class AddMaxConcurrentCheck < ActiveRecord::Migration[7.2]
  def change
    add_check_constraint :pause_types,
      "max_concurrent > 0",
      name: "check_positive_max_concurrent"
  end
end
