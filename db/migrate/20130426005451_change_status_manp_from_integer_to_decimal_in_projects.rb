class ChangeStatusManpFromIntegerToDecimalInProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :status_manp
    add_column :projects, :status_manp, :decimal
  end

  def down
    remove_column :projects, :status_manp
    add_column :projects, :status_manp, :integer
  end
end
