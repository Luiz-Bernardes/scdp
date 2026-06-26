class AddPauseDurationCheck < ActiveRecord::Migration[7.2]
  def change
    add_check_constraint :pauses,
      "selected_duration_minutes IS NULL OR selected_duration_minutes > 0",
      name: "check_positive_selected_duration"
  end
end
