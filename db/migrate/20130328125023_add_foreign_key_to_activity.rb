class AddForeignKeyToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :project_id, :integer
    add_column :activities, :team, :text
  end
end
