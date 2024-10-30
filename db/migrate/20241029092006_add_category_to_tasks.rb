class AddCategoryToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :category, foreign_key: true, null: true
  end
end