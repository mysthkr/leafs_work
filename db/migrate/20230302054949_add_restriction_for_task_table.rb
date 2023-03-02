class AddRestrictionForTaskTable < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :task_detail, :string, null: false
  end
end
