class ChangedStatusMsTypeToTextInProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :status_ms
    add_column :projects, :status_ms, :text
  end

  def down
    remove_column :projects, :status_ms
    add_column :projects, :status_ms, :integer
  end
end
