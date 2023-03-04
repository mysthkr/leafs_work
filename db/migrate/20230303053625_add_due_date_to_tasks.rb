class AddDueDateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :due_date, :datetime, null: false, default: "Thu, 02 Mar 2023 15:21:26.640399000 JST +09:00"
  end
end
