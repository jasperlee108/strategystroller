class RemoveColumnFromProject < ActiveRecord::Migration
  def up
    remove_column :projects, :owner
    remove_column :projects, :steer
  end

  def down
    add_column :projects, :owner, :string
    add_column :projects, :steer, :string
  end
end
