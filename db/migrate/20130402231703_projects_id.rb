class ProjectsId < ActiveRecord::Migration
  def change
    add_column :projects, :form_id, :integer
  end
end
