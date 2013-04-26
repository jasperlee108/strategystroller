class ChangedStatusMsTypeToTextInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :status_ms, :text
  end

  def down
    change_column :projects, :status_ms, :integer
  end
end
