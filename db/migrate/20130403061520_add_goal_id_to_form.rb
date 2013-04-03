class AddGoalIdToForm < ActiveRecord::Migration
  def change
    add_column :forms, :goal_id, :integer
  end
end
