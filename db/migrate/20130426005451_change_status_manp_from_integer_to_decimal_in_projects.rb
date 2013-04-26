class ChangeStatusManpFromIntegerToDecimalInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :status_manp, :decimal
  end

  def down
    change_column :projects, :status_manp, :integer
  end
end
