class AddProjIdToForm < ActiveRecord::Migration
  def change
    add_column :forms, :project_id, :integer
  end
end
