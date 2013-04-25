class AddForeignKeyToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :goal_id, :integer
    add_column :indicators, :user_id, :integer
  end
end
