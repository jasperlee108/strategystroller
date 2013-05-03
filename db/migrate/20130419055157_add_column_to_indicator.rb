class AddColumnToIndicator < ActiveRecord::Migration
  def change
    add_column :indicators, :contributing_projects_status, :float
  end
end
