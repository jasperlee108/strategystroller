class AddForeignKeyToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :dimension_id, :integer
    add_column :goals, :user_id, :integer
  end
end
