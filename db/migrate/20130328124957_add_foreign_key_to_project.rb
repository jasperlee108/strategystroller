class AddForeignKeyToProject < ActiveRecord::Migration
  def change
    add_column :projects, :indicator_id, :integer
    add_column :projects, :head_id, :integer
    add_column :projects, :steer_id, :integer
  end
end
